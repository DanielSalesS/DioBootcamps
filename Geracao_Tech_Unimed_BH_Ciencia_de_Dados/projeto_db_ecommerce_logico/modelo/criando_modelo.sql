-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `idCliente` INT NOT NULL,
  `Identification` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Type` ENUM('Pessoa Física', 'Pessoa Jurídica') CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Identification_UNIQUE` (`Identification` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order` (
  `idOrder` INT NOT NULL,
  `Description` VARCHAR(45) NOT NULL,
  `Status` ENUM('Cancelado', 'Confirmado', 'Em processamento') NOT NULL DEFAULT 'Em processamento',
  `OrderDate` DATE NOT NULL,
  `Client_idCliente` INT NOT NULL,
  PRIMARY KEY (`idOrder`, `Client_idCliente`),
  INDEX `fk_Order_Client1_idx` (`Client_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Order_Client1`
    FOREIGN KEY (`Client_idCliente`)
    REFERENCES `mydb`.`Client` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `idProduct` INT NOT NULL,
  `Category` ENUM('Eletrodomésticos', 'Informática', 'Brinquedos', 'Mercado', 'Móveis') NULL,
  `Description` VARCHAR(45) NULL,
  `UnitValue` FLOAT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `idSupplier` INT NOT NULL,
  `CorporateName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSupplier`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock` (
  `idStock` INT NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idStock`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TerceiroVendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TerceiroVendedor` (
  `idTerceiroVendedor` INT NOT NULL,
  `CorporateName` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiroVendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Delivery` (
  `idDelivery` INT NOT NULL,
  `Status` ENUM('Em Separação', 'A caminho', 'Entregue') NOT NULL DEFAULT 'Em Separação',
  `TrackingCode` VARCHAR(45) NOT NULL,
  `Pedido_Cliente_idCliente` DATE NULL,
  `Previsao de entrega` DATE NULL,
  `Order_idOrder` INT NOT NULL,
  PRIMARY KEY (`idDelivery`, `Order_idOrder`),
  INDEX `fk_Delivery_Order1_idx` (`Order_idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_Delivery_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PhysicalPerson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PhysicalPerson` (
  `idPhysicalPerson` INT NOT NULL,
  `FirstName` VARCHAR(10) NOT NULL,
  `LastName` VARCHAR(40) NULL,
  `CPF` VARCHAR(14) NOT NULL,
  `BirthDate` DATE NOT NULL,
  `Client_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPhysicalPerson`),
  UNIQUE INDEX `CPF_UNIQUE` (`CPF` ASC) VISIBLE,
  INDEX `fk_PhysicalPerson_Client1_idx` (`Client_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_PhysicalPerson_Client1`
    FOREIGN KEY (`Client_idCliente`)
    REFERENCES `mydb`.`Client` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`LegalPerson`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`LegalPerson` (
  `idLegalPerson` INT NOT NULL,
  `CNPJ` VARCHAR(14) NOT NULL,
  `CorporateName` VARCHAR(45) NOT NULL,
  `Client_idCliente` INT NOT NULL,
  PRIMARY KEY (`idLegalPerson`),
  INDEX `fk_LegalPerson_Client1_idx` (`Client_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `CNPJ_UNIQUE` (`CNPJ` ASC) VISIBLE,
  CONSTRAINT `fk_LegalPerson_Client1`
    FOREIGN KEY (`Client_idCliente`)
    REFERENCES `mydb`.`Client` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CreditCard`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CreditCard` (
  `idCreditCard` INT NOT NULL,
  `Card Number` VARCHAR(16) NOT NULL,
  `Flag` VARCHAR(10) NOT NULL,
  `NameHolder` VARCHAR(45) NOT NULL,
  `CPFHolder` VARCHAR(14) NOT NULL,
  `Client_idCliente` INT NOT NULL,
  PRIMARY KEY (`idCreditCard`, `Client_idCliente`),
  INDEX `fk_CreditCard_Client1_idx` (`Client_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `CPFHolder_UNIQUE` (`CPFHolder` ASC) VISIBLE,
  CONSTRAINT `fk_CreditCard_Client1`
    FOREIGN KEY (`Client_idCliente`)
    REFERENCES `mydb`.`Client` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `idPayment` INT NOT NULL,
  `Status` ENUM('Não Pago', 'Pago', 'Aguardando Pagamento') NULL DEFAULT 'Aguardando Pagamento',
  `PaymentMethod` ENUM('Cartão de Crédito', 'Boleto') CHARACTER SET 'utf8' NOT NULL,
  `Order_idOrder` INT NOT NULL,
  `CreditCard_idCreditCard` INT NOT NULL,
  PRIMARY KEY (`idPayment`, `Order_idOrder`),
  INDEX `fk_Payment_Order1_idx` (`Order_idOrder` ASC) VISIBLE,
  INDEX `fk_Payment_CreditCard1_idx` (`CreditCard_idCreditCard` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_CreditCard1`
    FOREIGN KEY (`CreditCard_idCreditCard`)
    REFERENCES `mydb`.`CreditCard` (`idCreditCard`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Boleto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Boleto` (
  `idBoleto` INT NOT NULL,
  `ScannableLine` VARCHAR(45) NOT NULL,
  `Beneficiary` VARCHAR(15) NOT NULL,
  `ExpirationDate` DATE NOT NULL,
  `BankCode` VARCHAR(45) CHARACTER SET 'armscii8' NOT NULL,
  `Value` FLOAT NOT NULL,
  `Wallet` VARCHAR(30) NOT NULL,
  `DocumentDate` DATE NOT NULL,
  `Payment_idPayment` INT NOT NULL,
  PRIMARY KEY (`idBoleto`),
  INDEX `fk_Boleto_Payment1_idx` (`Payment_idPayment` ASC) VISIBLE,
  CONSTRAINT `fk_Boleto_Payment1`
    FOREIGN KEY (`Payment_idPayment`)
    REFERENCES `mydb`.`Payment` (`idPayment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_has_Product` (
  `Order_idOrder` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  PRIMARY KEY (`Order_idOrder`, `Product_idProduct`),
  INDEX `fk_Order_has_Product_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  INDEX `fk_Order_has_Product_Order1_idx` (`Order_idOrder` ASC) VISIBLE,
  CONSTRAINT `fk_Order_has_Product_Order1`
    FOREIGN KEY (`Order_idOrder`)
    REFERENCES `mydb`.`Order` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Product_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stock_has_Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock_has_Product` (
  `Stock_idStock` INT NOT NULL,
  `Product_idProduct` INT NOT NULL,
  `Quantity` INT NULL,
  PRIMARY KEY (`Stock_idStock`, `Product_idProduct`),
  INDEX `fk_Stock_has_Product_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  INDEX `fk_Stock_has_Product_Stock1_idx` (`Stock_idStock` ASC) VISIBLE,
  CONSTRAINT `fk_Stock_has_Product_Stock1`
    FOREIGN KEY (`Stock_idStock`)
    REFERENCES `mydb`.`Stock` (`idStock`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stock_has_Product_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_has_Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_has_Supplier` (
  `Product_idProduct` INT NOT NULL,
  `Supplier_idSupplier` INT NOT NULL,
  PRIMARY KEY (`Product_idProduct`, `Supplier_idSupplier`),
  INDEX `fk_Product_has_Supplier_Supplier1_idx` (`Supplier_idSupplier` ASC) VISIBLE,
  INDEX `fk_Product_has_Supplier_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_Product_has_Supplier_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Supplier_Supplier1`
    FOREIGN KEY (`Supplier_idSupplier`)
    REFERENCES `mydb`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ExternalSeller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ExternalSeller` (
  `idExternalSeller` INT NOT NULL,
  `CorporateName` VARCHAR(45) NOT NULL,
  `Local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idExternalSeller`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_has_ExternalSeller`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_has_ExternalSeller` (
  `Product_idProduct` INT NOT NULL,
  `ExternalSeller_idExternalSeller` INT NOT NULL,
  PRIMARY KEY (`Product_idProduct`, `ExternalSeller_idExternalSeller`),
  INDEX `fk_Product_has_ExternalSeller_ExternalSeller1_idx` (`ExternalSeller_idExternalSeller` ASC) VISIBLE,
  INDEX `fk_Product_has_ExternalSeller_Product1_idx` (`Product_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_Product_has_ExternalSeller_Product1`
    FOREIGN KEY (`Product_idProduct`)
    REFERENCES `mydb`.`Product` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_ExternalSeller_ExternalSeller1`
    FOREIGN KEY (`ExternalSeller_idExternalSeller`)
    REFERENCES `mydb`.`ExternalSeller` (`idExternalSeller`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
