import socket
import threading
import tkinter as tk
from tkinter.scrolledtext import ScrolledText
from tkinter import messagebox
import queue
from PIL import Image, ImageTk
import os
import sys
import select


class ToggleSwitch(tk.Canvas):
    def __init__(self, master=None, width=60, height=30, bg_color="#ccc", active_color="#4cd964",
                 handle_color="#ffffff", command=None, *args, **kwargs):
        super().__init__(master, width=width, height=height, bg=master['bg'], highlightthickness=0, *args, **kwargs)
        self.width = width
        self.height = height
        self.bg_color = bg_color
        self.active_color = active_color
        self.handle_color = handle_color
        self.command = command

        self.is_on = False
        self.enabled = True  # 表示开关是否可用
        self.handle_radius = (height - 10) / 2
        self.handle_x = 5  # 初始位置
        self.handle_y = height / 2

        # 绘制背景
        self.bg = self.create_rounded_rect(0, 0, width, height, radius=height / 2, fill=self.bg_color, outline="")

        # 绘制滑块
        self.handle = self.create_oval(self.handle_x, 5, self.handle_x + self.handle_radius * 2,
                                       5 + self.handle_radius * 2, fill=self.handle_color, outline="")

        # 绑定点击事件
        self.bind("<Button-1>", self.toggle)

    def create_rounded_rect(self, x1, y1, x2, y2, radius=25, **kwargs):
        points = [
            x1 + radius, y1,
            x1 + radius, y1,
            x2 - radius, y1,
            x2 - radius, y1,
            x2, y1,
            x2, y1 + radius,
            x2, y1 + radius,
            x2, y2 - radius,
            x2, y2 - radius,
            x2, y2,
            x2 - radius, y2,
            x2 - radius, y2,
            x1 + radius, y2,
            x1 + radius, y2,
            x1, y2,
            x1, y2 - radius,
            x1, y2 - radius,
            x1, y1 + radius,
            x1, y1 + radius,
            x1, y1
        ]
        return self.create_polygon(points, smooth=True, **kwargs)

    def toggle(self, event=None):
        if not self.enabled:
            return  # 如果被禁用，直接返回，不执行任何操作
        self.is_on = not self.is_on
        if self.is_on:
            target_x = self.width - self.height + 5
            self.itemconfig(self.bg, fill=self.active_color)
        else:
            target_x = 5
            self.itemconfig(self.bg, fill=self.bg_color)
        self.animate_handle(target_x)
        if self.command:
            self.command(self.is_on)

    def animate_handle(self, target_x):
        current_coords = self.coords(self.handle)
        current_x = current_coords[0]
        step = 2 if target_x > current_x else -2

        def move():
            nonlocal current_x
            if (step > 0 and current_x < target_x) or (step < 0 and current_x > target_x):
                current_x += step
                self.coords(self.handle, current_x, 5, current_x + self.handle_radius * 2, 5 + self.handle_radius * 2)
                self.after(10, move)
            else:
                # 确保最终位置
                self.coords(self.handle, target_x, 5, target_x + self.handle_radius * 2, 5 + self.handle_radius * 2)

        move()

    def set_enabled(self, enabled):
        self.enabled = enabled
        if not self.enabled:
            # 使开关看起来被禁用（灰度处理）
            self.itemconfig(self.bg, fill="#ddd")  # 背景变灰
            self.itemconfig(self.handle, fill="#aaa")  # 滑块变灰
        else:
            # 恢复原始颜色
            if self.is_on:
                self.itemconfig(self.bg, fill=self.active_color)
            else:
                self.itemconfig(self.bg, fill=self.bg_color)
            self.itemconfig(self.handle, fill=self.handle_color)

    def set_state(self, is_on, call_command=True):
        if self.is_on == is_on:
            return  # 状态未改变
        self.is_on = is_on
        if self.is_on:
            target_x = self.width - self.height + 5
            self.itemconfig(self.bg, fill=self.active_color)
        else:
            target_x = 5
            self.itemconfig(self.bg, fill=self.bg_color)
        self.animate_handle(target_x)
        if call_command and self.command:
            self.command(self.is_on)


class App:
    def __init__(self, master):
        self.master = master
        master.title("Car Control and Connection Status")

        # 状态栏
        self.status_frame = tk.Frame(master)
        self.status_frame.pack(pady=10)

        self.status_label = tk.Label(self.status_frame, text="Connection Setup", font=("Arial", 10))
        self.status_label.grid(row=0, column=0)

        self.connection_status = tk.Label(self.status_frame, text="Disconnected", bg="red", fg="white",
                                          font=("Arial", 10))
        self.connection_status.grid(row=0, column=1, padx=10)

        # 显示消息的文本区域
        self.text_area = ScrolledText(master, state='disabled', width=50, height=10)
        self.text_area.pack(pady=10)

        # 输入命令的标签
        self.command_label = tk.Label(master, text="Command Input", font=("Arial", 10))
        self.command_label.pack(pady=(10, 0))

        # 消息输入框
        self.entry = tk.Entry(master, width=30)
        self.entry.pack(pady=5)

        # 绑定回车键发送消息
        self.entry.bind("<Return>", self.send_message)

        # 创建一个队列来保存接收的消息
        self.queue = queue.Queue()

        # 初始化连接变量
        self.conn = None
        self.addr = None
        self.server_socket = None

        # 加载图像
        self.load_images()

        # 创建一个框架来容纳图像
        self.image_frame = tk.Frame(self.master)
        self.image_frame.pack(pady=20)

        # 显示四个方向的图像（保持原始尺寸）
        self.display_directional_images()

        # 显示暂停/开始的图像（调整大小）
        self.display_pause_start_image()

        # 定义键到位的映射
        self.key_to_bit = {'w': 1, 'a': 2, 's': 4, 'd': 8}

        # 初始化按键状态和消息队列
        self.keys_pressed = set()
        self.message_queue = queue.Queue()
        self.message_sending_in_progress = False

        # 跟踪最后发送的独热码
        self.last_sent_bitmask = None

        # 初始化暂停状态
        self.is_paused = False

        # 绑定 WASD 键盘事件和空格键
        self.bind_keys()

        # 创建一个框架来容纳三个 ToggleSwitch
        self.toggle_frame = tk.Frame(master)
        self.toggle_frame.pack(pady=10)

        # 创建 ToggleSwitches 并添加到 toggle_frame
        self.toggle_switch = ToggleSwitch(self.toggle_frame, width=60, height=30, command=self.on_toggle_switch)
        self.toggle_switch.pack(side='left', padx=5)

        # 创建红色和蓝色的 ToggleSwitch
        self.red_toggle = ToggleSwitch(self.toggle_frame, width=60, height=30, bg_color="red",
                                       active_color="red", command=self.on_red_toggle)
        self.red_toggle.pack(side='left', padx=5)

        self.blue_toggle = ToggleSwitch(self.toggle_frame, width=60, height=30, bg_color="green",
                                        active_color="green", command=self.on_blue_toggle)
        self.blue_toggle.pack(side='left', padx=5)

        # 初始化时禁用红色和蓝色的开关
        self.red_toggle.set_enabled(False)
        self.blue_toggle.set_enabled(False)

        # 创建一个框架来容纳新增的按钮
        self.button_frame = tk.Frame(master)
        self.button_frame.pack(pady=10)

        # 添加舵机控制按钮
        self.special_button = tk.Button(self.button_frame, text="servo down", command=self.send_special_command,
                                        width=20,
                                        bg="orange")
        self.special_button.pack(pady=5)

        # 状态变量用于切换发送的指令
        self.special_command_state = False  # False: 11110000 (0xF0), True: 11000000 (0xC0)

        # 初始化蜂鸣器级别变量
        self.buzzer_level = 0
        self.buzzer_max_level = 4
        self.buzzer_min_level = 0

        # 创建一个框架用于蜂鸣器控制按钮
        self.buzzer_frame = tk.Frame(self.button_frame)
        self.buzzer_frame.pack(pady=5)

        # 创建“-”按钮用于减少蜂鸣器级别
        self.buzzer_minus_button = tk.Button(
            self.buzzer_frame, text="-", command=self.decrease_buzzer_level
        )
        self.buzzer_minus_button.pack(side='left', padx=5)

        # 创建“+”按钮用于增加蜂鸣器级别
        self.buzzer_plus_button = tk.Button(
            self.buzzer_frame, text="+", command=self.increase_buzzer_level
        )
        self.buzzer_plus_button.pack(side='left', padx=5)

        # 显示当前蜂鸣器级别的标签
        self.buzzer_level_label = tk.Label(
            self.buzzer_frame, text=f"Buzzer Level: {self.buzzer_level}"
        )
        self.buzzer_level_label.pack(side='left', padx=5)

        # 更新蜂鸣器控件以设置初始状态
        self.update_buzzer_controls()

        # **添加速度控制按钮**

        # 初始化速度级别变量
        self.speed_level = 0
        self.speed_max_level = 4  # 修改为最高级别 4
        self.speed_min_level = 0

        # 定义速度级别对应的二进制值列表
        self.speed_values = [0xAF, 0x8F, 0x4F, 0x2F, 0x1F]  # 移除最高级别 0x0F

        # 创建一个框架用于速度控制按钮
        self.speed_frame = tk.Frame(self.button_frame)
        self.speed_frame.pack(pady=5)

        # 创建“-”按钮用于减少速度级别
        self.speed_minus_button = tk.Button(
            self.speed_frame, text="-", command=self.decrease_speed_level
        )
        self.speed_minus_button.pack(side='left', padx=5)

        # 创建“+”按钮用于增加速度级别
        self.speed_plus_button = tk.Button(
            self.speed_frame, text="+", command=self.increase_speed_level
        )
        self.speed_plus_button.pack(side='left', padx=5)

        # 显示当前速度级别的标签
        self.speed_level_label = tk.Label(
            self.speed_frame, text=f"Speed Level: {self.speed_level}"
        )
        self.speed_level_label.pack(side='left', padx=5)

        # 更新速度控件以设置初始状态
        self.update_speed_controls()

        # 启动 socket 服务器线程
        self.socket_thread = threading.Thread(target=self.run_socket_server, daemon=True)
        self.socket_thread.start()

        # 定期检查消息队列
        self.master.after(1000, self.process_queue)
        self.master.after(1000, self.process_message_queue)

        # 添加底部状态栏
        self.add_bottom_status_bar()

        # 启动持续发送独热码的定时任务
        self.master.after(1000, self.continuous_send_bitmask)

        # 处理窗口关闭事件
        master.protocol("WM_DELETE_WINDOW", self.on_closing)

    def load_images(self):
        # 使用相对路径和 os 模块构建文件路径
        script_dir = os.path.dirname(os.path.abspath(__file__))

        # 图像路径
        image_paths = {
            'gray_up': os.path.join(script_dir, 'triangle_gray_up.png'),
            'green_up': os.path.join(script_dir, 'triangle_green_up.png'),
            'gray_down': os.path.join(script_dir, 'triangle_gray_down.png'),
            'green_down': os.path.join(script_dir, 'triangle_green_down.png'),
            'gray_left': os.path.join(script_dir, 'triangle_gray_left.png'),
            'green_left': os.path.join(script_dir, 'triangle_green_left.png'),
            'gray_right': os.path.join(script_dir, 'triangle_gray_right.png'),
            'green_right': os.path.join(script_dir, 'triangle_green_right.png'),
            'pause': os.path.join(script_dir, 'pause.png'),  # 新增
            'start': os.path.join(script_dir, 'start.png'),  # 新增
        }

        # 定义暂停和开始图片的目标大小
        pause_start_size = (50, 50)  # 您可以根据需要调整尺寸

        # 安全地加载图像
        try:
            # 加载四个方向的图片（保持原始尺寸）
            self.gray_up_img = ImageTk.PhotoImage(Image.open(image_paths['gray_up']))
            self.green_up_img = ImageTk.PhotoImage(Image.open(image_paths['green_up']))
            self.gray_down_img = ImageTk.PhotoImage(Image.open(image_paths['gray_down']))
            self.green_down_img = ImageTk.PhotoImage(Image.open(image_paths['green_down']))
            self.gray_left_img = ImageTk.PhotoImage(Image.open(image_paths['gray_left']))
            self.green_left_img = ImageTk.PhotoImage(Image.open(image_paths['green_left']))
            self.gray_right_img = ImageTk.PhotoImage(Image.open(image_paths['gray_right']))
            self.green_right_img = ImageTk.PhotoImage(Image.open(image_paths['green_right']))

            # 加载并缩放暂停和开始图片
            try:
                resample_filter = Image.Resampling.LANCZOS
            except AttributeError:
                resample_filter = Image.LANCZOS

            pause_image = Image.open(image_paths['pause']).resize(pause_start_size, resample_filter)
            self.pause_img = ImageTk.PhotoImage(pause_image)

            start_image = Image.open(image_paths['start']).resize(pause_start_size, resample_filter)
            self.start_img = ImageTk.PhotoImage(start_image)
        except Exception as e:
            messagebox.showerror("Image Loading Error", f"Error loading images: {e}")
            self.master.destroy()
            sys.exit(1)

    def display_directional_images(self):
        # 创建标签以显示方向图像
        self.up_label = tk.Label(self.image_frame, image=self.gray_up_img)
        self.up_label.grid(row=0, column=1)

        self.left_label = tk.Label(self.image_frame, image=self.gray_left_img)
        self.left_label.grid(row=1, column=0)

        self.down_label = tk.Label(self.image_frame, image=self.gray_down_img)
        self.down_label.grid(row=2, column=1)

        self.right_label = tk.Label(self.image_frame, image=self.gray_right_img)
        self.right_label.grid(row=1, column=2)

    def display_pause_start_image(self):
        # 创建一个标签来显示暂停/开始的图片（调整大小）
        self.pause_start_label = tk.Label(self.image_frame, image=self.start_img)
        self.pause_start_label.grid(row=1, column=1, padx=10)  # 放置在中心位置

    def bind_keys(self):
        # 绑定按键事件到主窗口
        self.master.bind("<KeyPress-w>", self.on_key_press)
        self.master.bind("<KeyRelease-w>", self.on_key_release)
        self.master.bind("<KeyPress-s>", self.on_key_press)
        self.master.bind("<KeyRelease-s>", self.on_key_release)
        self.master.bind("<KeyPress-a>", self.on_key_press)
        self.master.bind("<KeyRelease-a>", self.on_key_release)
        self.master.bind("<KeyPress-d>", self.on_key_press)
        self.master.bind("<KeyRelease-d>", self.on_key_release)

        # 绑定空格键事件
        self.master.bind("<KeyPress-space>", self.on_space_press)

    def add_bottom_status_bar(self):
        # 创建底部状态栏
        self.bottom_status_label = tk.Label(self.master, text="Auto Mode Off", bg="red", bd=1, relief=tk.SUNKEN,
                                            anchor='w', font=("Arial", 10))
        self.bottom_status_label.pack(side='bottom', fill='x')

    def run_socket_server(self):
        HOST = ''  # 监听所有接口
        PORT = 80  # 使用一个非特权端口（避免权限问题）

        try:
            self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.server_socket.bind((HOST, PORT))
            self.server_socket.listen()
            self.server_socket.setblocking(False)
            self.queue.put(f"Server is listening on port {PORT}")
        except Exception as e:
            self.queue.put(f"Error starting server: {e}")
            return

        inputs = [self.server_socket]
        outputs = []

        while True:
            try:
                readable, writable, exceptional = select.select(inputs, outputs, inputs, 0.5)
                for s in readable:
                    if s is self.server_socket:
                        # 接受新连接
                        conn, addr = self.server_socket.accept()
                        conn.setblocking(False)
                        inputs.append(conn)
                        self.conn = conn
                        self.addr = addr
                        self.queue.put(f"Connected to {addr}")
                        self.update_status("Connected", "green")
                    else:
                        # 接收来自客户端的数据
                        data = s.recv(1024)
                        if data:
                            received = data.hex().strip()
                            if received:
                                self.queue.put("Received from Arduino: " + received)
                        else:
                            # 无数据表示客户端已断开连接
                            inputs.remove(s)
                            s.close()
                            self.queue.put("Arduino has closed the connection")
                            self.update_status("Disconnected", "red")
                            self.conn = None
                            self.addr = None
                for s in exceptional:
                    inputs.remove(s)
                    s.close()
            except Exception as e:
                self.queue.put("Socket error: " + str(e))
                break

    def process_queue(self):
        try:
            while True:
                message = self.queue.get_nowait()
                self.display_message(message)
        except queue.Empty:
            pass
        self.master.after(100, self.process_queue)

    def display_message(self, message):
        # 确保此方法在主线程中运行
        self.text_area.config(state='normal')
        self.text_area.insert('end', message + '\n')
        self.text_area.see('end')
        self.text_area.config(state='disabled')

    def send_message(self, event=None):
        message = self.entry.get()
        if message:
            if self.conn:
                try:
                    # 将输入转换为字节
                    try:
                        # 尝试将输入解释为二进制字符串
                        message_int = int(message, 2)
                        message_bytes = message_int.to_bytes(1, byteorder='big')
                    except ValueError:
                        # 如果不是二进制字符串，尝试将其作为整数处理
                        message_int = int(message)
                        message_bytes = message_int.to_bytes(1, byteorder='big')
                    self.conn.sendall(message_bytes)
                    self.display_message(f"Sent to Arduino: {message_bytes.hex()}")
                    self.entry.delete(0, 'end')  # 发送后清空输入框
                except Exception as e:
                    self.display_message("Error sending message: " + str(e))
                    self.update_status("Disconnected", "red")
                    self.conn = None
            else:
                self.display_message("Not connected to Arduino")
        else:
            self.display_message("No message to send")

    def update_status(self, status_text, color):
        # 在主线程中更新 GUI
        self.master.after(0, lambda: self.connection_status.config(text=status_text, bg=color))

    def on_closing(self):
        if self.conn:
            try:
                self.conn.shutdown(socket.SHUT_RDWR)
                self.conn.close()
            except Exception:
                pass
        if self.server_socket:
            try:
                self.server_socket.close()
            except Exception:
                pass
        self.master.destroy()
        sys.exit(0)  # 确保脚本退出

    # 处理消息队列，确保消息之间有一定的间隔
    def process_message_queue(self):
        if not self.message_sending_in_progress and not self.message_queue.empty():
            self.send_next_message()
        self.master.after(100, self.process_message_queue)  # 定期检查队列

    def send_next_message(self):
        if not self.message_queue.empty():
            message = self.message_queue.get()
            if self.conn:
                try:
                    if isinstance(message, bytes):
                        # 如果 message 是字节类型，直接发送
                        self.conn.sendall(message)
                        self.display_message(f"Sent to Arduino: {message.hex()}")
                    elif isinstance(message, int):
                        # 如果 message 是整数，转换为字节
                        message_bytes = message.to_bytes(1, byteorder='big')
                        self.conn.sendall(message_bytes)
                        self.display_message(f"Sent to Arduino: {message_bytes.hex()}")
                    else:
                        self.display_message("Invalid message format.")
                    self.message_sending_in_progress = True
                    self.master.after(100, self.message_sent)
                except Exception as e:
                    self.display_message(f"Error sending message: {e}")
                    self.update_status("Disconnected", "red")
                    self.conn = None
            else:
                self.display_message("Not connected to Arduino")
                self.message_sending_in_progress = False
        else:
            self.message_sending_in_progress = False

    def message_sent(self):
        self.message_sending_in_progress = False
        # 不需要立即发送下一个消息，process_message_queue 会处理

    def on_key_press(self, event):
        key = event.keysym.lower()
        if key in self.key_to_bit and self.master.focus_get() != self.entry and not self.is_paused:
            if self.toggle_switch.is_on:
                self.toggle_switch.set_state(False)

            if key not in self.keys_pressed:
                self.keys_pressed.add(key)
                self.update_direction_labels()
                # 不在此处发送消息，改为由定时任务发送

    def on_key_release(self, event):
        key = event.keysym.lower()
        if key in self.key_to_bit and self.master.focus_get() != self.entry and not self.is_paused:
            if key in self.keys_pressed:
                self.keys_pressed.discard(key)
                self.update_direction_labels()
                # 不在此处发送消息，改为由定时任务发送

    def update_direction_labels(self):
        # 更新方向图标的颜色
        if 'w' in self.keys_pressed:
            self.up_label.config(image=self.green_up_img)
        else:
            self.up_label.config(image=self.gray_up_img)

        if 'a' in self.keys_pressed:
            self.left_label.config(image=self.green_left_img)
        else:
            self.left_label.config(image=self.gray_left_img)

        if 's' in self.keys_pressed:
            self.down_label.config(image=self.green_down_img)
        else:
            self.down_label.config(image=self.gray_down_img)

        if 'd' in self.keys_pressed:
            self.right_label.config(image=self.green_right_img)
        else:
            self.right_label.config(image=self.gray_right_img)

    def on_space_press(self, event):
        if self.master.focus_get() != self.entry:
            self.is_paused = not self.is_paused  # 切换状态
            if self.is_paused:
                self.pause_start_label.config(image=self.pause_img)
                self.message_queue.put(0x10)  # 发送暂停消息，表示停止
            else:
                self.pause_start_label.config(image=self.start_img)
                self.message_queue.put(0x00)
                # 发送当前按键的独热码
                bitmask = 0
                for key in self.keys_pressed:
                    bitmask |= self.key_to_bit[key]
                self.message_queue.put(bitmask)
            self.process_message_queue()

    def on_toggle_switch(self, is_on):
        if is_on:
            message = 0xFF  # 自动模式开启时发送 11111111
            self.bottom_status_label.config(text="Auto Mode On", bg="green")
            # 启用红色和蓝色的开关
            self.red_toggle.set_enabled(True)
            self.blue_toggle.set_enabled(True)
        else:
            message = 0x00  # 自动模式关闭时发送 00000000
            self.bottom_status_label.config(text="Auto Mode Off", bg="red")
            # 禁用红色和蓝色的开关
            self.red_toggle.set_enabled(False)
            self.blue_toggle.set_enabled(False)
            # 重置红色和蓝色开关的状态
            self.red_toggle.set_state(False)
            self.blue_toggle.set_state(False)
        self.message_queue.put(message)
        self.process_message_queue()

    def on_red_toggle(self, is_on):
        if is_on:
            if self.blue_toggle.is_on:
                self.blue_toggle.set_state(False)
            self.message_queue.put(0x80)  # 10000000
        else:
            self.message_queue.put(0x40)  # 01000000

    def on_blue_toggle(self, is_on):
        if is_on:
            if self.red_toggle.is_on:
                self.red_toggle.set_state(False)
            self.message_queue.put(0x20)  # 00100000
        else:
            self.message_queue.put(0x10)  # 00010000

    def continuous_send_bitmask(self):
        if not self.is_paused and not self.toggle_switch.is_on and self.conn:
            # 计算当前独热码
            bitmask = 0
            for key in self.keys_pressed:
                bitmask |= self.key_to_bit[key]

            # 将 bitmask 转换为字节类型
            bitmask_bytes = bitmask.to_bytes(1, byteorder='big')

            # 如果没有按下任何键，发送 0x00
            if not self.keys_pressed:
                bitmask_bytes = (0).to_bytes(1, byteorder='big')

            # 发送独热码
            self.message_queue.put(bitmask_bytes)

            self.last_sent_bitmask = bitmask_bytes

        self.master.after(100, self.continuous_send_bitmask)

    def send_special_command(self):
        if self.conn:
            try:
                if not self.special_command_state:
                    # 当前状态为 False，发送 00110000
                    special_byte = 0x30
                    self.special_button.config(text="servo up")  # 更新按钮文本
                else:
                    # 当前状态为 True，发送 11000000
                    special_byte = 0xC0
                    self.special_button.config(text="servo down")
                # 切换状态
                self.special_command_state = not self.special_command_state

                # 将字节添加到消息队列
                self.message_queue.put(special_byte)
            except Exception as e:
                self.display_message("Error sending special command: " + str(e))
                self.update_status("Disconnected", "red")
                self.conn = None
        else:
            self.display_message("Not connected to Arduino")

    def increase_buzzer_level(self):
        if self.buzzer_level < self.buzzer_max_level:
            self.buzzer_level += 1
            value = 0xF0 | (1 << (self.buzzer_level - 1))
            self.message_queue.put(value)
            self.process_message_queue()
            self.update_buzzer_controls()
        else:
            # 达到最大级别，禁用“+”按钮
            self.buzzer_plus_button.config(state='disabled')

    def decrease_buzzer_level(self):
        if self.buzzer_level > self.buzzer_min_level:
            self.buzzer_level -= 1
            if self.buzzer_level == 0:
                value = 0xF0
            else:
                value = 0xF0 | (1 << (self.buzzer_level - 1))
            self.message_queue.put(value)
            self.process_message_queue()
            self.update_buzzer_controls()
        else:
            # 达到最小级别，禁用“-”按钮
            self.buzzer_minus_button.config(state='disabled')

    def update_buzzer_controls(self):
        # 更新蜂鸣器级别标签
        self.buzzer_level_label.config(text=f"Buzzer Level: {self.buzzer_level}")
        # 根据当前级别启用或禁用按钮
        if self.buzzer_level <= self.buzzer_min_level:
            self.buzzer_minus_button.config(state='disabled')
        else:
            self.buzzer_minus_button.config(state='normal')

        if self.buzzer_level >= self.buzzer_max_level:
            self.buzzer_plus_button.config(state='disabled')
        else:
            self.buzzer_plus_button.config(state='normal')

    def increase_speed_level(self):
        if self.speed_level < self.speed_max_level:
            self.speed_level += 1
            value = self.speed_values[self.speed_level]
            self.message_queue.put(value)
            self.process_message_queue()
            self.update_speed_controls()
        else:
            # 达到最大级别，禁用“+”按钮
            self.speed_plus_button.config(state='disabled')

    def decrease_speed_level(self):
        if self.speed_level > self.speed_min_level:
            self.speed_level -= 1
            value = self.speed_values[self.speed_level]
            self.message_queue.put(value)
            self.process_message_queue()
            self.update_speed_controls()
        else:
            # 达到最小级别，禁用“-”按钮
            self.speed_minus_button.config(state='disabled')

    def update_speed_controls(self):
        # 更新速度级别标签
        self.speed_level_label.config(text=f"Speed Level: {self.speed_level}")
        # 根据当前级别启用或禁用按钮
        if self.speed_level <= self.speed_min_level:
            self.speed_minus_button.config(state='disabled')
        else:
            self.speed_minus_button.config(state='normal')

        if self.speed_level >= self.speed_max_level:
            self.speed_plus_button.config(state='disabled')
        else:
            self.speed_plus_button.config(state='normal')


if __name__ == "__main__":
    root = tk.Tk()
    app = App(root)
    root.mainloop()