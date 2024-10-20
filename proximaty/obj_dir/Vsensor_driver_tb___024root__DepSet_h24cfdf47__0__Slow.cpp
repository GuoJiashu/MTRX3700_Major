// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsensor_driver_tb.h for the primary calling header

#include "Vsensor_driver_tb__pch.h"
#include "Vsensor_driver_tb___024root.h"

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_static__TOP(Vsensor_driver_tb___024root* vlSelf);

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_static(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_static\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vsensor_driver_tb___024root___eval_static__TOP(vlSelf);
    vlSelfRef.__Vm_traceActivity[1U] = 1U;
    vlSelfRef.__Vm_traceActivity[0U] = 1U;
}

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_static__TOP(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_static__TOP\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW = 0U;
    vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm = 0U;
}

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_initial__TOP(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_initial__TOP\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.sensor_driver_tb__DOT__clk = 0U;
}

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_final(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_final\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__stl(Vsensor_driver_tb___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vsensor_driver_tb___024root___eval_phase__stl(Vsensor_driver_tb___024root* vlSelf);

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_settle(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_settle\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelfRef.__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vsensor_driver_tb___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("sensor_driver_tb.sv", 1, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vsensor_driver_tb___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelfRef.__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__stl(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___dump_triggers__stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VstlTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vsensor_driver_tb___024root___stl_sequent__TOP__0(Vsensor_driver_tb___024root* vlSelf);

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_stl(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1ULL & vlSelfRef.__VstlTriggered.word(0U))) {
        Vsensor_driver_tb___024root___stl_sequent__TOP__0(vlSelf);
    }
}

VL_ATTR_COLD void Vsensor_driver_tb___024root___stl_sequent__TOP__0(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___stl_sequent__TOP__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.sensor_driver_tb__DOT__LEDR = (vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm 
                                             >> 0x18U);
}

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_triggers__stl(Vsensor_driver_tb___024root* vlSelf);

VL_ATTR_COLD bool Vsensor_driver_tb___024root___eval_phase__stl(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_phase__stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vsensor_driver_tb___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelfRef.__VstlTriggered.any();
    if (__VstlExecute) {
        Vsensor_driver_tb___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__act(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___dump_triggers__act\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VactTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge sensor_driver_tb.clk)\n");
    }
    if ((2ULL & vlSelfRef.__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__nba(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___dump_triggers__nba\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    if ((1U & (~ vlSelfRef.__VnbaTriggered.any()))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge sensor_driver_tb.clk)\n");
    }
    if ((2ULL & vlSelfRef.__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @([true] __VdlySched.awaitingCurrentTime())\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vsensor_driver_tb___024root___ctor_var_reset(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___ctor_var_reset\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelf->sensor_driver_tb__DOT__clk = VL_RAND_RESET_I(1);
    vlSelf->sensor_driver_tb__DOT__echo = VL_RAND_RESET_I(1);
    vlSelf->sensor_driver_tb__DOT__reset = VL_RAND_RESET_I(1);
    vlSelf->sensor_driver_tb__DOT__LEDR = VL_RAND_RESET_I(8);
    vlSelf->sensor_driver_tb__DOT__enable = VL_RAND_RESET_I(1);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__counter = VL_RAND_RESET_I(10);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__distanceRAW = VL_RAND_RESET_I(22);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm = VL_RAND_RESET_I(32);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__counterDONE = VL_RAND_RESET_I(1);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__state = VL_RAND_RESET_I(3);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__timer_counter = VL_RAND_RESET_I(25);
    vlSelf->sensor_driver_tb__DOT__u0__DOT__display_counter = VL_RAND_RESET_I(25);
    vlSelf->__Vtrigprevexpr___TOP__sensor_driver_tb__DOT__clk__0 = VL_RAND_RESET_I(1);
    for (int __Vi0 = 0; __Vi0 < 2; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
