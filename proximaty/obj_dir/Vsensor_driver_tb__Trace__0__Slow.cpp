// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vsensor_driver_tb__Syms.h"


VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_init_sub__TOP__0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd* tracep) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_init_sub__TOP__0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->pushPrefix("sensor_driver_tb", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+20,0,"CLK_PERIOD",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+15,0,"clk",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+16,0,"echo",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"trigger",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+17,0,"reset",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+18,0,"LEDR",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBit(c+19,0,"enable",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("u0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+21,0,"ten_us",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBit(c+15,0,"clk",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+17,0,"rst",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+16,0,"echo",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+19,0,"enable",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"trig",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+18,0,"distance",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+22,0,"IDLE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+23,0,"TRIGGER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+24,0,"WAIT",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+25,0,"COUNTECHO",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+26,0,"DISPLAY_DISTANCE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+2,0,"inIDLE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"inTRIGGER",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+3,0,"inWAIT",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+4,0,"inCOUNTECHO",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+5,0,"inDISPLAY",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+6,0,"counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 9,0);
    tracep->declBus(c+7,0,"distanceRAW",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 21,0);
    tracep->declBus(c+8,0,"distanceRAW_in_cm",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+9,0,"trigcountDONE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+27,0,"counterDONE",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+10,0,"state",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+11,0,"measure",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+2,0,"ready",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+12,0,"timer_counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 24,0);
    tracep->declBus(c+13,0,"display_counter",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 24,0);
    tracep->declBit(c+14,0,"display",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_init_top(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd* tracep) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_init_top\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    Vsensor_driver_tb___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vsensor_driver_tb___024root__trace_chg_0(void* voidSelf, VerilatedVcd::Buffer* bufp);
void Vsensor_driver_tb___024root__trace_cleanup(void* voidSelf, VerilatedVcd* /*unused*/);

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_register(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd* tracep) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_register\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    tracep->addConstCb(&Vsensor_driver_tb___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vsensor_driver_tb___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vsensor_driver_tb___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vsensor_driver_tb___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_const_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_const_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_const_0\n"); );
    // Init
    Vsensor_driver_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsensor_driver_tb___024root*>(voidSelf);
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vsensor_driver_tb___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_const_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_const_0_sub_0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullIData(oldp+20,(0x14U),32);
    bufp->fullSData(oldp+21,(0x2aaU),10);
    bufp->fullCData(oldp+22,(0U),3);
    bufp->fullCData(oldp+23,(2U),3);
    bufp->fullCData(oldp+24,(3U),3);
    bufp->fullCData(oldp+25,(4U),3);
    bufp->fullCData(oldp+26,(5U),3);
    bufp->fullBit(oldp+27,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counterDONE));
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_full_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp);

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_full_0(void* voidSelf, VerilatedVcd::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_full_0\n"); );
    // Init
    Vsensor_driver_tb___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vsensor_driver_tb___024root*>(voidSelf);
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vsensor_driver_tb___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vsensor_driver_tb___024root__trace_full_0_sub_0(Vsensor_driver_tb___024root* vlSelf, VerilatedVcd::Buffer* bufp) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root__trace_full_0_sub_0\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,((2U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
    bufp->fullBit(oldp+2,((0U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
    bufp->fullBit(oldp+3,((3U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
    bufp->fullBit(oldp+4,((4U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
    bufp->fullBit(oldp+5,((5U == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state))));
    bufp->fullSData(oldp+6,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter),10);
    bufp->fullIData(oldp+7,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW),22);
    bufp->fullIData(oldp+8,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm),32);
    bufp->fullBit(oldp+9,((0x2aaU == (IData)(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__counter))));
    bufp->fullCData(oldp+10,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__state),3);
    bufp->fullBit(oldp+11,((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter)));
    bufp->fullIData(oldp+12,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__timer_counter),25);
    bufp->fullIData(oldp+13,(vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter),25);
    bufp->fullBit(oldp+14,((0x32U == vlSelfRef.sensor_driver_tb__DOT__u0__DOT__display_counter)));
    bufp->fullBit(oldp+15,(vlSelfRef.sensor_driver_tb__DOT__clk));
    bufp->fullBit(oldp+16,(vlSelfRef.sensor_driver_tb__DOT__echo));
    bufp->fullBit(oldp+17,(vlSelfRef.sensor_driver_tb__DOT__reset));
    bufp->fullCData(oldp+18,(vlSelfRef.sensor_driver_tb__DOT__LEDR),8);
    bufp->fullBit(oldp+19,(vlSelfRef.sensor_driver_tb__DOT__enable));
}
