package br.com.desafiodeprojeto.padroesdeprojetos.facade;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import br.com.desafiodeprojeto.padroesdeprojetos.model.BankSlipPayment;
import br.com.desafiodeprojeto.padroesdeprojetos.model.CreditCardPayment;
import br.com.desafiodeprojeto.padroesdeprojetos.service.PaymentService;

@Component
public class PaymentFacade {

    @Autowired
    private PaymentService paymentService;

    public void payByCreditCard() {
        paymentService.processPayment(new CreditCardPayment());
    }

    public void payByBankSlip() {
        paymentService.processPayment(new BankSlipPayment());
    }

}