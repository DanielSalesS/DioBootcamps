package br.com.desafiodeprojeto.padroesdeprojetos.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import br.com.desafiodeprojeto.padroesdeprojetos.facade.PaymentFacade;

@RestController
public class PaymentController {

  @Autowired
  private PaymentFacade paymentFacade;

  @PostMapping("/payments/credit-card")
  public ResponseEntity<?> payByCreditCard() {
    paymentFacade.payByCreditCard();
    return ResponseEntity.ok().build();
  }

  @PostMapping("/payments/bank-slip")
  public ResponseEntity<?> payByBankSlip() {
    paymentFacade.payByBankSlip();
    return ResponseEntity.ok().build();
  }

}
