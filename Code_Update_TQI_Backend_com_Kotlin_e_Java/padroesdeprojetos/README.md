# Sistema de Pagamentos

Um sistema de pagamentos simples utilizando Spring Boot e implementando alguns padrões de projeto.

## Tecnologias Utilizadas

- Java 17
- Spring Boot
- Maven

## Padrões de Projeto

- Singleton
- Strategy 
- Facade

## Funcionalidades

- Processamento de pagamentos via cartão de crédito
- Processamento de pagamentos via boleto bancário
- API REST para iniciar os processos de pagamento

## Estrutura do Projeto

```
.
├── src
│   └── main
│       └── java
│           └── br
│               └── com
│                   └── desafiodeprojeto
│                       └── padroesdeprojetos
│                           ├── controller
│                           │   └── PaymentController.java
│                           ├── facade
│                           │   └── PaymentFacade.java
│                           ├── model
│                           │   ├── BankSlipPayment.java
│                           │   ├── CreditCardPayment.java 
│                           │   └── Payment.java
│                           └── service
│                               ├── PaymentService.java
│                               └── PaymentServiceImpl.java
└── pom.xml
```
