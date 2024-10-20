// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vsensor_driver_tb__Syms.h"


void Vsensor_driver_tb___024root__trace_chg_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

void Vsensor_driver_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_chg_0\n"); );
    // Init
    Vsensor_driver_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsensor_driver_tb___024root*>(voidSelf);
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vsensor_driver_tb___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vsensor_driver_tb___024root__trace_chg_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_chg_0_sub_0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelfRef.__Vm_traceActivity[1U])) {
        bufp->chgBit(oldp+0,((2U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
        bufp->chgBit(oldp+1,((0U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
        bufp->chgBit(oldp+2,((3U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
        bufp->chgBit(oldp+3,((4U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
        bufp->chgBit(oldp+4,((5U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
        bufp->chgSData(oldp+5,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter),10);
        bufp->chgIData(oldp+6,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW),22);
        bufp->chgIData(oldp+7,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm),32);
        bufp->chgBit(oldp+8,((0x2aaU == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter))));
        bufp->chgCData(oldp+9,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state),3);
        bufp->chgBit(oldp+10,((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter)));
        bufp->chgIData(oldp+11,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter),25);
        bufp->chgIData(oldp+12,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter),25);
        bufp->chgBit(oldp+13,((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter)));
    }
    bufp->chgBit(oldp+14,(vlSelfRef.sensor_driver_tb__DOT__clk));
    bufp->chgBit(oldp+15,(vlSelfRef.sensor_driver_tb__DOT__echo));
    bufp->chgBit(oldp+16,(vlSelfRef.sensor_driver_tb__DOT__reset));
    bufp->chgCData(oldp+17,(vlSelfRef.sensor_driver_tb__DOT__LEDR),8);
    bufp->chgBit(oldp+18,(vlSelfRef.sensor_driver_tb__DOT__enable));
}

void Vsensor_driver_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_cleanup\n"); );
    // Init
    Vsensor_driver_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsensor_driver_tb___024root*>(voidSelf);
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
