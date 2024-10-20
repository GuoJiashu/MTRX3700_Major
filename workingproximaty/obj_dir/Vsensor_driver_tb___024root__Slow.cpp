// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsensor_driver_tb.h for the primary calling header

#include "Vsensor_driver_tb__pch.h"
#include "Vsensor_driver_tb__Syms.h"
#include "Vsensor_driver_tb___024root.h"

void Vsensor_driver_tb___024root___ctor_var_reset(Vsensor_driver_tb___024root* vlSelf);

Vsensor_driver_tb___024root::Vsensor_driver_tb___024root(Vsensor_driver_tb__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , __VdlySched{*symsp->_vm_contextp__}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vsensor_driver_tb___024root___ctor_var_reset(this);
}

void Vsensor_driver_tb___024root::__Vconfigure(bool first) {
    (void)first;  // Prevent unused variable warning
}

Vsensor_driver_tb___024root::~Vsensor_driver_tb___024root() {
}
