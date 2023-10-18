package me.dio.credit.application.system.service.impl

import me.dio.credit.application.system.entity.Credit
import me.dio.credit.application.system.exception.BusinessException
import me.dio.credit.application.system.repository.CreditRepository
import org.springframework.stereotype.Service
import java.lang.IllegalArgumentException
import java.time.LocalDate
import java.util.*

@Service
class CreditService(
  private val creditRepository: CreditRepository,
  private val customerService: CustomerService
) : ICreditService {

  companion object {
    const val MAX_INSTALLMENTS = 48
    const val MAX_MONTHS_AFTER_CURRENT_DATE: Long = 3
  }

  override fun save(credit: Credit): Credit {
    this.validDayFirstInstallment(credit.dayFirstInstallment)
    this.validMaxInstallments(credit.installments)
    credit.apply {
      customer = customerService.findById(credit.customer?.id!!)
    }
    return this.creditRepository.save(credit)
  }

  override fun findAllByCustomer(customerId: Long): List<Credit> =
    this.creditRepository.findAllByCustomerId(customerId)

  override fun findByCreditCode(customerId: Long, creditCode: UUID): Credit {
    val credit: Credit = (this.creditRepository.findByCreditCode(creditCode)
      ?: throw BusinessException("Creditcode $creditCode not found"))
    return if (credit.customer?.id == customerId) credit
    else throw IllegalArgumentException("Contact admin")
  }

  private fun validMaxInstallments(installments: Int): Boolean {
    return if (installments <= MAX_INSTALLMENTS) true
    else throw BusinessException("O número máximo de parcelas permitido é $MAX_INSTALLMENTS")
  }

  private fun validDayFirstInstallment(dayFirstInstallment: LocalDate): Boolean {
    return if (dayFirstInstallment.isBefore(LocalDate.now().plusMonths(MAX_MONTHS_AFTER_CURRENT_DATE))) true
    else throw BusinessException("A data da primeira parcela deve ser no máximo $MAX_MONTHS_AFTER_CURRENT_DATE meses após o dia atual")
  }
}
