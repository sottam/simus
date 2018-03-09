unit ResString;

{$mode delphi}

interface

uses
  Classes, SysUtils, DefaultTranslator;

resourcestring
  //uSimus
  STudoFoiSalvo = 'Tudo foi salvo?';
  SDesejaSalvarAntesDeSair = 'Deseja salvar antes de sair?';
  SInforme = 'Informe';
  SNovoValorDoPC = 'Novo valor do PC';
  SNovoValorDoAcc = 'Novo valor do ACC';
  SNovoValorDoFlagZ = 'Novo valor do flag Z';
  SNovoValorDoFlagN = 'Novo valor do flag N';
  SNovoValorDoFlagC = 'Novo valor do flag C';

  S_SimuladorDoProcSapiens8 = ' - Simulador do processador Sapiens-8';
  SSimuladorDoProcSapiens8 = 'Simulador do processador Sapiens-8';

  SErroAoCarregarArquivo = 'Erro ao carregar o arquivo';
  SPrograma = '; Programa:';
  SAutor =    '; Autor:' ;
  SData =     '; Data:';

  SListagem = 'Listagem'; // primeira palavra da frase: Listagem da tabela de símbolos
  S___Sapiens8 = '   SAPIENS-8';

  //uAssemb
  S________Atencao = '********* Atenção: ';
  S________Erro = '********* Erro: ';
  SCadeiasComecamETerminamPorAspasOuPlics = 'Cadeias começam e terminam por aspas ou plics.';
  SPseudoInstrucaoNaoPermiteImediatoNemIndireto = 'Pseudo-instrução não permite imediato nem indireto';
  SComentarioOuParametroMalFormado = 'Comentário ou parâmetro mal formado';
  SNumeroDeErrosEncontrados = 'Número de erros encontrados: ';
  SRotuloDuplicado = ' - rótulo duplicado';
  SParametroDoEQUcomErro = 'Parâmetro do EQU com erro';
  SOperandoInvalido = 'Operando inválido';
  SInstrucaoInvalida = 'Instrução inválida';
  SEstaInstrucaoNaoPossuiParametros = 'Esta instrução não possui parâmetros';
  SOTipoDeParametroEIncompativelComAInstrucao = 'O tipo de parâmetro é incompatível com a instrução';
  SOperandoMalFormado = 'Operando mal formado';
  SOrigemInvalida = 'Origem inválida';
  SSimbolo_________Linha__Endereco = 'Símbolo         Linha  Endereço';
  SCompilacaoEmAssemblyDoTexto = 'Compilação (assembly) do texto ';
  S_Em = 'Em '; // precede escrita da Data
  S_DaTabelaDeSimbolos = ' da tabela de símbolos'; //inicio completado pela palavra listagem contiaem uSimus

  //uHex
  SValorDigitadoInconsistente = 'Valor digitado inconsistente com a base especificada';

  //uAutoProg

  SPorfavorPreenchaOOperando = 'Por favor, preencha o operando';
  SPorFavorPreenchaORotulo = 'Por favor, preencha o rótulo';

  SNOP = 'O comando NOP (no operation) é usado apenas para gastar tempo.';

  SHLT = 'O comando HLT (halt) para a máquina.';

  SSTA = 'O comando STA (store accumulator) transfere o valor do acumulador para a posição de memória indicada pelo operando.';

  SLDA =  'O comando LDA (load accumulator) atribui ao acumulador o conteúdo da posição de memória indicada pelo operando.';

  SADD = 'O comando ADD soma ao acumulador o conteúdo de uma posição de memória indicada pelo operando.';

  SADC = 'O comando ADC (add with carry) soma ao acumulador o conteúdo de uma posição de memória indicada pelo operando, acrescido do valor do Carry (vai um).';

  SSUB = 'O comando SUB (subtract) subtrai do acumulador o conteúdo de uma posição de memória indicada pelo operando.';

  SSBC = 'O comando SBC (subtract with carry) subtrai do acumulador o conteúdo de uma posição de memória indicada pelo operando, decrementando-o se o carry ligado.';

  SNOT = 'O comando NOT (negate) transforma 1 em 0 e 0 em 1 nos bits do acumulador.';

  SAND = 'O comando AND realiza um "e" lógico entre o acumulador e o conteúdo de uma posição de memória indicada pelo operando.';

  SOR = 'O comando OR realiza um "ou" lógico entre o acumulador e o conteúdo  de uma posição de memória indicada pelo operando.';

  SXOR = 'O comando XOR (exclusive OR) realiza um "xor" lógico entre o acumulador e o conteúdo de uma posição de memória indicada pelo operando.';

  SSHL = 'O comando SHL (shift left) desloca os bits do acumulador para a esquerda (ou seja, multiplica por 2). O bit 0 recebe o valor 0. O bit 7 (que seria perdido) é armazenado no Carry.';

  SSHR = 'O comando SHR (shift right) desloca os bits do acumulador para a direita (ou seja, divide por 2).  O bit 7 recebe o valor 0. O bit 0 (que seria perdido) é armazenado no Carry.';

  SSHA = 'O comando SHA(shift right aritmético) desloca os bits do acumulador para a direita (ou seja, divide por 2). O bit 7 é mantido igual. O bit 0 (que seria perdido) é armazenado no Carry.';

  SIN = 'O comando IN (input) carrega no acumulador o valor lido num dispositivo externo indicado pelo operando.  Nesse simulador os dispositivos são: chaves (endereço 0) e o status de "dado disponível" das chaves (endereço 1).';

  SOUT = 'O comando OUT (output) transfere o valor do acumulador para um dispositivo externo indicado pelo operando.  Nesse simulador o único dispositivo disponível é um visor (endereço 0).';

  STRAP = 'O comando TRAP simula a execução uma função de sistema operacional, para simplificar a programação de entrada e saída.';

  SJMP = 'O comando JMP (jump) desvia a execução do programa para o endereço indicado pelo operando (ou seja, coloca este endereço no registrador PC).';

  SJN = 'O comando JN (jump if negative) desvia a execução do programa para o endereço indicado pelo operando, apenas quando a última operação realizada produziu um valor com o bit 7 ligado.';

  SJZ = 'O comando JZ (jump if zero) desvia a execução do programa para o endereço indicado pelo operando, apenas quando a última operação realizada produziu um valor zero';

  SJNZ = 'O comando JNZ (jump if not zero) desvia a execução do programa para o endereço indicado pelo operando ender, apenas quando a última operação realizada produziu um valor diferente de zero.';

  SJC =  'O comando JC (jump if carry) desvia a execução do programa para o endereço indicado pelo operando ender, apenas quando a última operação aritmética realizada não coube nos 8 bits do destino.';

  SJNC = 'O comando JNC (jump if not carry) desvia a execução do programa para o endereço indicado pelo operando ender, apenas quando a última operação aritmética realizada coube nos 8 bits do destino.';

  SORG = 'A pseudo-instrução ORG (origin) indica ao assembler a posição de memória onde será colocada a próxima instrução.';

  SEQU =  'A pseudo-instrução EQU (equate) atribui um nome a um certo valor. Esse comando é frequentemente usado para especificar variáveis que são posicionadas em certo endereço de memória. Por exemplo para posicionar a variável x no endereço hexa f0 use: X EQU 0F0H';

  SEND = 'A pseudo-instrução END indica que o programa fonte acabou. O operando é usado para pré-carregar o PC com o endereço inicial de execução do programa.';

  SDS = 'A pseudo-instrução DS (define storage) reserva um número de palavras na memória definido pelo operando.';

  SDB = 'A pseudo-instrução DB (define bytes) carrega nesta palavra de memória o valor definido pelo operando.';

  SPontoEVirgula = 'Os comentários são começados por ponto e vírgula.';

  SDoisPontos = 'Um rótulo é um nome dado à posição de memória da instrução a seguir. O nome é seguido por dois pontos';

  SSTS = 'O comando STS (store into stack pointer) transfere 16 bits da memória indicada pelo operando para o apontador da pilha (Stack Pointer).';

  SLDS = 'O comando STS (load from stack pointer) transfere o apontador da pilha (Stack Pointer) para 16 bits na memória indicada pelo operando.';

  SJSR = 'O comando JSR (jump to subroutine) executa uma chamada de subrotina. Para isso, transfere os 16 bits do PC (Program Counter) para a pilha e coloca no PC os 16 bits indicados no operando.  O SP é decrementado de 2.';

  SRET = 'O comando RET (return from subroutine), retorna de uma chamada JSR. Para isso, transfere para o PC 16 bits da pilha, e atualiza o SP. O SP é decrementado de 2.';

  SPUSH = 'O comando PUSH (push to stack), coloca o conteúdo do acumulador no topo da pilha.  O SP é decrementado de 1.';

  SPOP = 'O comando POP (pop from stack), traz para o acumulador o topo da pilha (8 bits). O SP é decrementado de 1.';


implementation

end.

