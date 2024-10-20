// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vsensor_driver_tb.h for the primary calling header

#include "Vsensor_driver_tb__pch.h"
#include "Vsensor_driver_tb__Syms.h"
#include "Vsensor_driver_tb___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vsensor_driver_tb___024root___dump_triggers__stl(Vsensor_driver_tb___024root* vlSelf);
#endif  // VL_DEBUG

VL_ATTR_COLD void Vsensor_driver_tb___024root___eval_triggers__stl(Vsensor_driver_tb___024root* vlSelf) {
    (void)vlSelf;  // Prevent unused variable warning
    Vsensor_driver_tb__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vsensor_driver_tb___024root___eval_triggers__stl\n"); );
    auto &vlSelfRef = std::ref(*vlSelf).get();
    // Body
    vlSelfRef.__VstlTriggered.set(0U, (IData)(vlSelfRef.__VstlFirstIteration));
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vsensor_driver_tb___024root___dump_triggers__stl(vlSelf);
    }
#endif
}
