unit ResString;

{$mode delphi}

interface

uses
  Classes, SysUtils, DefaultTranslator;

resourcestring
  //uSimus
  STudoFoiSalvo = 'Are you sure?';
  SDesejaSalvarAntesDeSair = 'Save before exiting?';
  SInforme = 'Insert';
  SNovoValorDoPC = 'New PC value';
  SNovoValorDoAcc = 'New ACC value';
  SNovoValorDoFlagZ = 'New flag Z value';
  SNovoValorDoFlagN = 'New flag N value';
  SNovoValorDoFlagC = 'New flag C value';

  S_SimuladorDoProcSapiens8 = ' - Sapiens-8 processor simulator';
  SSimuladorDoProcSapiens8 = 'Sapiens-8 processor simulator';

  SErroAoCarregarArquivo = 'Error when loading file';
  SPrograma = '; Program:';
  SAutor =    '; Author:' ;
  SData =     '; Date:';

  SListagem = 'List'; // primeira palavra da frase: Listagem da tabela de símbolos
  S___Sapiens8 = 'SAPIENS-8';

  //uAssemb
  S________Atencao = '********* Warning: ';
  S________Erro = '********* Error: ';
  SCadeiasComecamETerminamPorAspasOuPlics = 'Strings start and end with quotation marks.';
  SPseudoInstrucaoNaoPermiteImediatoNemIndireto = 'Pseudo-instruction does not permit immediate neither indirect';
  SComentarioOuParametroMalFormado = 'Malformed comment or parameter';
  SNumeroDeErrosEncontrados = 'Number of errors found: ';
  SRotuloDuplicado = ' - duplicate label';
  SParametroDoEQUcomErro = 'EQU Parameter with error';
  SOperandoInvalido = 'Invalid operand';
  SInstrucaoInvalida = 'Illegal instruction';
  SEstaInstrucaoNaoPossuiParametros = 'This instruction has no parameters';
  SOTipoDeParametroEIncompativelComAInstrucao = 'This parameter type is incompatible with the instruction';
  SOperandoMalFormado = 'Malformed operand';
  SOrigemInvalida = 'Invalid source';
  SSimbolo_________Linha__Endereco = 'Symbol           Line  Address';
  SCompilacaoEmAssemblyDoTexto = 'Compilation Report: ';
  S_Em = 'In '; // precede escrita da Data
  S_DaTabelaDeSimbolos = ' of symbol table'; //inicio completado pela palavra listagem contida em uSimus

  //uHex
  SValorDigitadoInconsistente = 'Typed value inconsistent with specified base';

  //uAutoProg

  SPorfavorPreenchaOOperando = 'Please, fill in the operand.';
  SPorFavorPreenchaORotulo = 'Please fill in the label.';

  SNOP = 'NOP (no operation) does nothing.';

  SHLT = 'HLT (halt) stops the machine.';

  SSTA = 'STA (store accumulator) transfers the value of the accumulator to the memory location indicated by the operand.';

  SLDA = 'LDA (load accumulator) assigns the accumulator the contents of the memory location indicated by the operand.';

  SADD = 'ADD instruction adds the contents of the memory position to the contents of the accumulator. The result is stored in the accumulator.';

  SADC = 'ADC (add with carry) instruction adds the contents of the memory position to the contents of the accumulator and the carry.';

  SSUB = 'SUB (subtract) instruction subtracts from the accumulator the contents of a memory location indicated by the operand.';

  SSBC = 'SBC (subtract with carry) subtracts from the accumulator the contents of a memory location indicated by the operand, decreasing it if the carry is on.';

  SNOT = 'NOT complements the accumulator contents. In other words, it flips ''1''s  into ''0''s  and ''0''s into ''1''s.';

  SAND = 'AND performs a binary "AND" between the accumulator and the contents of a memory location indicated by the operand.';

  SOR = 'OR performs a logical  "OR" between the accumulator and the contents of a memory location indicated by the operand.';

  SXOR = 'XOR (exclusive OR) performs a logical "xor" between the accumulator and the contents of a memory location indicated by the operand.';

  SSHL = 'SHL (shift left) instruction shifts the accumulator bits to the left (the same as multiplying by 2). Bit 0 is set to 0. Bit 7 (which would be lost) is stored in the Carry.';

  SSHR = 'SHR (shift right) instruction shifts the accumulator bits to the right (the same as dividing by 2). Bit 7 is set to 0. Bit 0 (which would be lost) is stored in the Carry.';

  SSHA = 'SHA (shift right arithmetic) instruction shifts the accumulator bits to the right (the same as divide by 2). Bit 7 is kept the same. Bit 0 (which would be lost) is stored in the Carry.';

  SIN = 'IN (input) loads the value read into an external device indicated by the operand in the accumulator. In this simulator the devices are: keys (address 0) and the status of  "data available " of the keys (address 1).';

  SOUT = 'OUT (output) transfers the accumulator  value to an external device indicated by the operand. In this simulator the only available device is a display (address 0).';

  STRAP = 'TRAP simulates an operating system function, to simplify input and output programming.';

  SJMP = 'JMP (jump) transfers program execution to the memory address given in the operand, (i.e., it places this address into PC register).';

  SJN = 'JN (jump if negative) transfers program execution to the memory address given in the operand, only when the last operation performed produced a value with bit 7 connected.';

  SJZ = 'JZ (jump if zero) transfers program execution to the memory address given in the operand, only when the last executed operation produced a zero value.';

  SJNZ = 'JNZ (jump if not zero) transfers program execution to the memory address given in the operand, only when the last operation performed produced a nonzero value.';

  SJC =  'JC (jump if carry) transfers program execution to the memory address given in the operand, only if carry flag equals ''1".';

  SJNC = 'JNC (jump if not carry) transfers program execution to the memory address given in the operand, only if carry flag equals ''0".';

  SORG = 'ORG (origin) pseudo-instruction indicates to the assembler the memory location where the next instruction will be placed.';

  SEQU =  'EQU (equate) pseudo-instruction assigns an alias to a numeric value. This command is often used to define a specific memory address to a program variable. For example, to position the variable X into  F0H address you shall use: X EQU 0F0H';

  SEND = 'END pseudo-instruction indicates that the source program has ended. This operand is used to pre-load the PC with the starting address of the program execution.';

  SDS = 'DS (define storage) pseudo-instruction reserves in memory the amount of bytes specified by the operand.';

  SDB = 'DB (define bytes) pseudo-instruction loads the value defined by the operand into the current memory position.';

  SPontoEVirgula = 'Comments start with a semicolon.';

  SDoisPontos = 'A label is a name given to the current memory position. The name must be followed by a colon.';

  SSTS = 'STS (store into stack pointer) transfers 16 bits of the memory indicated by the operand to the stack pointer (Stack Pointer).';

  SLDS = 'LDS (load from stack pointer) transfers the stack pointer to 16 bits in the memory indicated by the operand.';

  SJSR = 'JSR (jump to subroutine) executes a subroutine call. To do this, transfer the 16 bits of the PC (Program Counter) to the stack and put in the PC the 16 bits indicated in the operand. The SP is incremented by 2.';

  SRET = 'RET (return from subroutine) instruction returns from a JSR call. In other words, it transfers 16 bits of the stack to the PC, and updates the SP. The SP is decremented by 2.';

  SPUSH = 'PUSH (push to stack) copies the contents of the accumulator to the top of the stack. The SP is incremented by 1.';

  SPOP = 'POP (pop from stack) copies the top of the stack (8 bits) to the accumulator. The SP is decremented by 1.';


implementation

end.

