// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vsensor_driver_tb.h for the primary calling header

#ifndef VERILATED_VSENSOR_DRIVER_TB___024ROOT_H_
#define VERILATED_VSENSOR_DRIVER_TB___024ROOT_H_  // guard

#include "verilated.h"
#include "verilated_timing.h"


class Vsensor_driver_tb__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vsensor_driver_tb___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ sensor_driver_tb__DOT__clk;
    CData/*0:0*/ sensor_driver_tb__DOT__echo;
    CData/*0:0*/ sensor_driver_tb__DOT__reset;
    CData/*7:0*/ sensor_driver_tb__DOT__LEDR;
    CData/*0:0*/ sensor_driver_tb__DOT__enable;
    CData/*0:0*/ sensor_driver_tb__DOT__u0__DOT__counterDONE;
    CData/*2:0*/ sensor_driver_tb__DOT__u0__DOT__state;
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__sensor_driver_tb__DOT__clk__0;
    CData/*0:0*/ __VactContinue;
    SData/*9:0*/ sensor_driver_tb__DOT__u0__DOT__counter;
    IData/*21:0*/ sensor_driver_tb__DOT__u0__DOT__distanceRAW;
    IData/*31:0*/ sensor_driver_tb__DOT__u0__DOT__distanceRAW_in_cm;
    IData/*24:0*/ sensor_driver_tb__DOT__u0__DOT__timer_counter;
    IData/*24:0*/ sensor_driver_tb__DOT__u0__DOT__display_counter;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlDelayScheduler __VdlySched;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<2> __VactTriggered;
    VlTriggerVec<2> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vsensor_driver_tb__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vsensor_driver_tb___024root(Vsensor_driver_tb__Syms* symsp, const char* v__name);
    ~Vsensor_driver_tb___024root();
    VL_UNCOPYABLE(Vsensor_driver_tb___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
