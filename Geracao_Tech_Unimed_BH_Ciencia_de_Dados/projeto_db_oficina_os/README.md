# Construindo um Esquema Conceitual para Banco De dados

## Levantamento de Requisitos

### Narrativa

- Sistema de controle e gerenciamento de execução de ordens de serviço em uma oficina mecânica


- Clientes levam veículos à oficina mecânica para serem consertados ou para passarem por revisões  periódicas

- Cada veículo é designado a uma equipe de mecânicos que identifica os serviços a serem executados e preenche uma OS com data de entrega.

- A partir da OS, calcula-se o valor de cada serviço, consultando-se uma tabela de referência de mão-de-obra

- O valor de cada peça também irá compor a OSO cliente autoriza a execução dos serviços

- A mesma equipe avalia e executa os serviços

- Os mecânicos possuem código, nome, endereço e especialidade

- Cada OS possui: n°, data de emissão, um valor, status e uma data para conclusão dos trabalhos.

### Narrativa - Produto
- Os produtos são vendidos por uma única plataforma online.
Contudo, estes podem ter vendedores distintos (terceiros)

- Cada produto possui um fornecedor

- Um ou mais produtos podem compor um pedido


## Modelo 

![Modelo](images/modelo.png)


