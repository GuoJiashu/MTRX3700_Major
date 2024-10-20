// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsensor_driver_tb.h for the primary calling header

#include "Vsensor_driver_tb__pch.h"
#include "Vsensor_driver_tb__Syms.h"
#include "Vsensor_driver_tb___024root.h"

VL_INLINE_OPT VlCoroutine Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__0(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlWide<3>/*95:0*/ __Vtemp_1;
    // Body
    vlSelfRef.sensor_driver_tb__DOT__reset = 1U;
    vlSelfRef.sensor_driver_tb__DOT__echo = 0U;
    vlSelfRef.sensor_driver_tb__DOT__enable = 0U;
    __Vtemp_1[0U] = 0x2e766364U;
    __Vtemp_1[1U] = 0x666f726dU;
    __Vtemp_1[2U] = 0x77617665U;
    vlSymsp->_vm_contextp__->dumpfile(VL_CVT_PACK_STR_NW(3, __Vtemp_1));
    vlSymsp->_traceDumpOpen();
    co_await vlSelfRef.__VdlySched.delay(0x14ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         37);
    vlSelfRef.sensor_driver_tb__DOT__LEDR = 0U;
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         40);
    vlSelfRef.sensor_driver_tb__DOT__reset = 0U;
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         42);
    vlSelfRef.sensor_driver_tb__DOT__enable = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x7d0ULL, 
                                         nullptr, "sensor_driver_tb.sv", 
                                         45);
    vlSelfRef.sensor_driver_tb__DOT__enable = 0U;
    co_await vlSelfRef.__VdlySched.delay(0x2710ULL, 
                                         nullptr, "sensor_driver_tb.sv", 
                                         47);
    vlSelfRef.sensor_driver_tb__DOT__echo = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x4e20ULL, 
                                         nullptr, "sensor_driver_tb.sv", 
                                         49);
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         51);
    vlSelfRef.sensor_driver_tb__DOT__echo = 0U;
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         54);
    vlSelfRef.sensor_driver_tb__DOT__echo = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x186a0ULL, 
                                         nullptr, "sensor_driver_tb.sv", 
                                         56);
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         58);
    vlSelfRef.sensor_driver_tb__DOT__echo = 0U;
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         61);
    vlSelfRef.sensor_driver_tb__DOT__echo = 1U;
    co_await vlSelfRef.__VdlySched.delay(0x30d40ULL, 
                                         nullptr, "sensor_driver_tb.sv", 
                                         63);
    co_await vlSelfRef.__VdlySched.delay(0x14ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         65);
    vlSelfRef.sensor_driver_tb__DOT__echo = 0U;
    co_await vlSelfRef.__VdlySched.delay(0xc8ULL, nullptr, 
                                         "sensor_driver_tb.sv", 
                                         68);
    VL_FINISH_MT("sensor_driver_tb.sv", 70, "");
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__act(Vsensor_driver_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vsensor_driver_tb___024root___eval_triggers__act(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_triggers__act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VactTriggered.set(0U, ((IData)(vlSelfRef.sensor_driver_tb__DOT__clk) 
                                       & (~ (IData)(vlSelfRef.__Vtrigprevexpr___TOP__sensor_driver_tb__DOT__clk__0))));
    vlSelfRef.__VactTriggered.set(1U, vlSelfRef.__VdlySched.awaitingCurrentTime());
    vlSelfRef.__Vtrigprevexpr___TOP__sensor_driver_tb__DOT__clk__0 
        = vlSelfRef.sensor_driver_tb__DOT__clk;
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vsensor_driver_tb___024root___dump_triggers__act(vlSelf);
    }
#endif
}
