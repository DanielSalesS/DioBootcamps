# **Documentando e Testando sua API Rest com Kotlin**

## Implementação de regras de negócio para solicitação de empréstimo

Este README descreve a implementação das regras de negócio para solicitação de empréstimo no projeto request-credit-system: https://github.com/cami-la/credit-application-system.

### Regras de negócio

As regras de negócio implementadas são as seguintes:

* O número máximo de parcelas permitido é 48.
* A data da primeira parcela deve ser no máximo 3 meses após o dia atual.

### Implementação

Para implementar as regras de negócio, adicionamos dois métodos à classe `CreditService`:

```kotlin
private fun validMaxInstallments(installments: Int): Boolean {
    return if (installments <= MAX_INSTALLMENTS) true
    else throw BusinessException("O número máximo de parcelas permitido é $MAX_INSTALLMENTS")
}

private fun validDayFirstInstallment(dayFirstInstallment: LocalDate): Boolean {
    return if (dayFirstInstallment.isBefore(LocalDate.now().plusMonths(MAX_MONTHS_AFTER_CURRENT_DATE))) true
    else throw BusinessException("A data da primeira parcela deve ser no máximo $MAX_MONTHS_AFTER_CURRENT_DATE meses após o dia atual")
}
```

Esses métodos verificam o número de parcelas e a data da primeira parcela, respectivamente.

Para usar as regras de negócio, modificamos o método `save()` da classe `CreditService` da seguinte forma:

```kotlin
override fun save(credit: Credit): Credit {
    this.validDayFirstInstallment(credit.dayFirstInstallment)
    this.validMaxInstallments(credit.installments)
    credit.apply {
        customer = customerService.findById(credit.customer?.id!!)
    }
    return this.creditRepository.save(credit)
}
```

Com essa modificação, o método `save()` lançará uma `BusinessException` se o número de parcelas for maior que o máximo permitido ou se a data da primeira parcela for posterior a 3 meses após o dia atual.

### Testes

Adicionamos os seguintes testes unitários à classe `CreditServiceTest` para verificar as regras de negócio:

```kotlin
@Test
fun `should not create credit when invalid max installments`() {
    //given
    val invalidMaxInstallments = MAX_INSTALLMENTS + 1
    val credit: Credit = buildCredit(installments = invalidMaxInstallments)

    every { creditRepository.save(any()) } answers { credit }
    //when
    Assertions.assertThatThrownBy { creditService.save(credit) }
      .isInstanceOf(BusinessException::class.java)
      .hasMessage("O número máximo de parcelas permitido é $MAX_INSTALLMENTS")
    //then
    verify(exactly = 0) { creditRepository.save(any()) }
}

@Test
fun `should not create credit when invalid day first installment`() {
    //given
    val invalidDayFirstInstallment: LocalDate = LocalDate.now().plusMonths(5)
    val credit: Credit = buildCredit(dayFirstInstallment = invalidDayFirstInstallment)

    every { creditRepository.save(any()) } answers { credit }
    //when
    Assertions.assertThatThrownBy { creditService.save(credit) }
      .isInstanceOf(BusinessException::class.java)
      .hasMessage("A data da primeira parcela deve ser no máximo $MAX_MONTHS_AFTER_CURRENT_DATE meses após o dia atual")
    //then
    verify(exactly = 0) { creditRepository.save(any()) }
}
```

Esses testes verificam se as regras de negócio são aplicadas corretamente.

### Conclusão

A implementação das regras de negócio para solicitação de empréstimo foi feita da seguinte forma:

* Adicionamos dois métodos à classe `CreditService` para verificar o número de parcelas e a data da primeira parcela.
* Modificamos o método `save()` da classe `CreditService` para usar as regras de negócio.
* Adicionamos testes unitários para verificar as regras de negócio.

Com essa implementação, podemos garantir que as solicitações de empréstimo sejam válidas.

### Citação do projeto original

Este README é baseado no README do projeto original request-credit-system: https://github.com/cami-la/credit-application-system. O projeto original foi desenvolvido por Camila Cavalcante.