enum class Nivel { BASICO, INTERMEDIARIO, DIFICIL }

class Usuario(val nome: String, val email: String, val phoneNumber: String)

data class ConteudoEducacional(var nome: String, val duracao: Int = 60)

class Formacao(val nome: String, var conteudos: List<ConteudoEducacional>) {

    val inscritos = mutableListOf<Usuario>()

    fun matricular(usuario: Usuario) {
        inscritos.add(usuario)
    }

    fun listarInscritos(): List<Usuario> {
        return inscritos.toList()
    }

    fun estaInscrito(usuario: Usuario): Boolean {
        return usuario in inscritos
    }
}


fun main() {
    
    val formacao = Formacao("Curso de Kotlin", listOf(
        ConteudoEducacional("Introdução ao Kotlin", 60),
        ConteudoEducacional("Programação Orientada a Objetos", 120)
    ))

    val usuario1 = Usuario("John Doe", "johndoe@example.com", "123456789")
    val usuario2 = Usuario("Jane Doe", "janedoe@example.com", "987654321")

    // Matricular os usuários
    formacao.matricular(usuario1)
    formacao.matricular(usuario2)

    // Listar os inscritos
    val inscritos = formacao.listarInscritos()
    for (inscrito in inscritos) {
    	println(inscrito.nome)
	}

    // Verificar se o usuário está inscrito
    val estaInscrito = usuario1 in formacao.inscritos
	println("O usuário ${usuario1.nome} está inscrito?")
    println(estaInscrito)
    
    val estaInscrito2 = usuario2 in formacao.inscritos
	println("O usuário ${usuario2.nome} está inscrito?")
    println(estaInscrito2)

}
