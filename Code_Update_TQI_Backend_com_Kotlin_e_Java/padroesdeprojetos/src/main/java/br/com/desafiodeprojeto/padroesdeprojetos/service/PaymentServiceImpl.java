package br.com.desafiodeprojeto.padroesdeprojetos.service;

import org.springframework.stereotype.Service;

import br.com.desafiodeprojeto.padroesdeprojetos.model.Payment;

@Service
public class PaymentServiceImpl implements PaymentService {

  @Override
  public void processPayment(Payment payment) {
    payment.pay();
  }

}