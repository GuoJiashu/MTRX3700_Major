// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsensor_driver_tb.h for the primary calling header

#include "Vsensor_driver_tb__pch.h"
#include "Vsensor_driver_tb___024root.h"

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_initial__TOP(Vsensor_driver_tb___024root* vlSelf);
VlCoroutine Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__0(Vsensor_driver_tb___024root* vlSelf);
VlCoroutine Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__1(Vsensor_driver_tb___024root* vlSelf);

void Vsensor_driver_tb___024root___eval_initial(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_initial\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vsensor_driver_tb___024root___eval_initial__TOP(vlSelf);
    Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__0(vlSelf);
    Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__1(vlSelf);
    vlSelfRef.__Vtrigprevexpr___TOP__sensor_driver_tb__DOT__clk__0 
        = vlSelfRef.sensor_driver_tb__DOT__clk;
}

VL_INLINE_OPT VlCoroutine Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__1(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_initial__TOP__Vtiming__1\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    while (1U) {
        co_await vlSelfRef.__VdlySched.delay(0xaULL, 
                                             nullptr, 
                                             "sensor_driver_tb.sv", 
                                             26);
        vlSelfRef.sensor_driver_tb__DOT__clk = (1U 
                                                & (~ (IData)(vlSelfRef.sensor_driver_tb__DOT__clk)));
    }
}

void Vsensor_driver_tb___024root___eval_act(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}

void Vsensor_driver_tb___024root___nba_sequent__TOP__0(Vsensor_driver_tb___024root* vlSelf);

void Vsensor_driver_tb___024root___eval_nba(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        Vsensor_driver_tb___024root___nba_sequent__TOP__0(vlSelf);
        vlSelfRef.__Vm_traceActivity[1U] = 1U;
    }
}

extern const VlUnpacked<CData/*0:0*/, 256> Vsensor_driver_tb__ConstPool__TABLE_haa518c7c_0;
extern const VlUnpacked<CData/*2:0*/, 256> Vsensor_driver_tb__ConstPool__TABLE_h75e3164e_0;

VL_INLINE_OPT void Vsensor_driver_tb___024root___nba_sequent__TOP__0(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___nba_sequent__TOP__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*7:0*/ __Vtableidx1;
    __Vtableidx1 = 0;
    IData/*24:0*/ __Vdly__sensor_driver_tb__DOT__u0__DOT__timer_counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__timer_counter = 0;
    IData/*24:0*/ __Vdly__sensor_driver_tb__DOT__u0__DOT__display_counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__display_counter = 0;
    CData/*2:0*/ __Vdly__sensor_driver_tb__DOT__u0__DOT__state;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__state = 0;
    SData/*9:0*/ __Vdly__sensor_driver_tb__DOT__u0__DOT__counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__counter = 0;
    IData/*21:0*/ __Vdly__sensor_driver_tb__DOT__u0__DOT__distanceRAW;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__distanceRAW = 0;
    // Body
    __Vdly__sensor_driver_tb__DOT__u0__DOT__distanceRAW 
        = vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__counter 
        = vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__display_counter 
        = vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__timer_counter 
        = vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__state = vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state;
    __Vdly__sensor_driver_tb__DOT__u0__DOT__distanceRAW 
        = ((3U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))
            ? 0U : ((0x3fffffU == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW)
                     ? 0x3fffffU : (0x3fffffU & (vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW 
                                                 + 
                                                 (4U 
                                                  == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))))));
    __Vdly__sensor_driver_tb__DOT__u0__DOT__counter 
        = ((0U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))
            ? 0U : (0x3ffU & ((IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter) 
                              + ((IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter) 
                                 | (2U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))))));
    if ((5U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))) {
        __Vdly__sensor_driver_tb__DOT__u0__DOT__display_counter 
            = ((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter)
                ? 0U : (0x1ffffffU & ((IData)(1U) + vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter)));
        vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm 
            = ((IData)(0x1648U) * vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW);
    }
    if (((0U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state)) 
         | (IData)(vlSelfRef.sensor_driver_tb__DOT__enable))) {
        __Vdly__sensor_driver_tb__DOT__u0__DOT__timer_counter 
            = ((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter)
                ? 0U : (0x1ffffffU & ((IData)(1U) + vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter)));
    }
    __Vtableidx1 = (((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter) 
                     << 7U) | (((IData)(vlSelfRef.sensor_driver_tb__DOT__echo) 
                                << 6U) | (((0x2aaU 
                                            == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter)) 
                                           << 5U) | 
                                          (((0x32U 
                                             == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter) 
                                            << 4U) 
                                           | (((IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state) 
                                               << 1U) 
                                              | (IData)(vlSelfRef.sensor_driver_tb__DOT__reset))))));
    if (Vsensor_driver_tb__ConstPool__TABLE_haa518c7c_0
        [__Vtableidx1]) {
        __Vdly__sensor_driver_tb__DOT__u0__DOT__state 
            = Vsensor_driver_tb__ConstPool__TABLE_h75e3164e_0
            [__Vtableidx1];
    }
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter 
        = __Vdly__sensor_driver_tb__DOT__u0__DOT__display_counter;
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter 
        = __Vdly__sensor_driver_tb__DOT__u0__DOT__counter;
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter 
        = __Vdly__sensor_driver_tb__DOT__u0__DOT__timer_counter;
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW 
        = __Vdly__sensor_driver_tb__DOT__u0__DOT__distanceRAW;
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state 
        = __Vdly__sensor_driver_tb__DOT__u0__DOT__state;
    vlSelfRef.sensor_driver_tb__DOT__LEDR = (vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm 
                                             >> 0x18U);
}

void Vsensor_driver_tb___024root___timing_resume(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___timing_resume\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((2ULL & vlSelfRef.__VactTriggered.word(0U))) {
        vlSelfRef.__VdlySched.resume();
    }
}

void Vsensor_driver_tb___024root___eval_triggers__act(Vsensor_driver_tb___024root* vlSelf);

bool Vsensor_driver_tb___024root___eval_phase__act(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_phase__act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    VlTriggerVec<2> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vsensor_driver_tb___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelfRef.__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelfRef.__VactTriggered, vlSelfRef.__VnbaTriggered);
        vlSelfRef.__VnbaTriggered.thisOr(vlSelfRef.__VactTriggered);
        Vsensor_driver_tb___024root___timing_resume(vlSelf);
        Vsensor_driver_tb___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vsensor_driver_tb___024root___eval_phase__nba(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_phase__nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelfRef.__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vsensor_driver_tb___024root___eval_nba(vlSelf);
        vlSelfRef.__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__nba(Vsensor_driver_tb___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__act(Vsensor_driver_tb___024root* vlSelf);
#endif  // VL_DEBUG

void Vsensor_driver_tb___024root___eval(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vsensor_driver_tb___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("sensor_driver_tb.sv", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelfRef.__VactIterCount = 0U;
        vlSelfRef.__VactContinue = 1U;
        while (vlSelfRef.__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelfRef.__VactIterCount))) {
#ifdef VL_DEBUG
                Vsensor_driver_tb___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("sensor_driver_tb.sv", 1, "", "Active region did not converge.");
            }
            vlSelfRef.__VactIterCount = ((IData)(1U) 
                                         + vlSelfRef.__VactIterCount);
            vlSelfRef.__VactContinue = 0U;
            if (Vsensor_driver_tb___024root___eval_phase__act(vlSelf)) {
                vlSelfRef.__VactContinue = 1U;
            }
        }
        if (Vsensor_driver_tb___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vsensor_driver_tb___024root___eval_debug_assertions(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_debug_assertions\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}
#endif  // VL_DEBUG
