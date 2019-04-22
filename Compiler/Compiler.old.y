%{

    #include <stdio.h>
    #include <iostream>
    #include <string.h>
    #include <bitset>
    #include <vector>
    #include <map>
    #include <stdlib.h>
    #include <algorithm>
    #include <cstdlib>
    #include <fstream>

    typedef struct ArmDataProcessingInstruction{
      std::string cond;
      std::string op;
      std::string i;
      std::string cmd;
      std::string s;
      std::string Rn;
      std::string Rd;
      std::string Sr2;
    } ArmDataProcessingInstruction;


    typedef struct ArmMemoryInstruction{
      std::string opcode;

    } ArmMemoryInstruction;


    typedef struct ArmBranchInstruction{
      std::string opcode;

    } ArmBranchInstruction;


    std::string DEFAULT_INSTRUCTION = "00000000000000000000000000000000";
    std::string current_instruction = "00000000000000000000000000000000";

    std::map<std::string,int> labels; //Etiquetas y valores
    std::map<std::string,int> futureLabels; //En caso de encontrar una etiqueta antes de ser declarada
    std::fstream fs;
    std::fstream fs2;
    std::string final_message="Compiler success";


    std::string NOP_INSTRUCTION = "11100001101000000000000000000000";


    /*Arm condition flags*/
    std::string CONDITION_EQ = "0000";
    std::string CONDITION_NE = "0000";
    std::string CONDITION_CS = "0000";
    std::string CONDITION_HS = "0000";
    std::string CONDITION_CC = "0000";
    std::string CONDITION_LO = "0000";
    std::string CONDITION_MI = "0000";
    std::string CONDITION_PL = "0000";
    std::string CONDITION_VS = "0000";
    std::string CONDITION_VC = "0000";
    std::string CONDITION_HI = "0000";
    std::string CONDITION_LS = "0000";
    std::string CONDITION_GE = "0000";
    std::string CONDITION_GT = "0000";
    std::string CONDITION_LT = "0000";
    std::string CONDITION_LE = "0000";
    std::string CONDITION_AL = "1110";


    /*Operation code of different instruction types.*/
    std::string OPCODE_DATA = "00";
    std::string OPCODE_MEMORY = "01";
    std::string OPCODE_BRANCH = "10";
    std::string OPCODE_SPECIALIZED = "11";


    /*
    Binary part of data instructions type. This part is called "cmd" part.
    */

    std::string BINARY_ADD_OPERATION = "1000";
    std::string BINARY_SUB_OPERATION = "0100";
    std::string BINARY_CPT_OPERATION = "1001";
    std::string BINARY_MUL_OPERATION = "0000";
    std::string BINARY_CMP_OPERATION = "0000";
    std::string BINARY_MOV_OPERATION = "0000";
    std::string BINARY_JMP_OPERATION = "0000";    
    std::string BINARY_NIL_OPERATION = "NULL";


    ArmDataProcessingInstruction data_ins;

    int memCount=0;
    int yylex();
    extern int yylineno;
    //Insertar una cierta cantidad


    void nop(int);
    void encondig_instruccion(std::string op,std::string rs,std::string rs2,std::string rd);
    void encode_register_inmediate_instruction(std::string op,std::string rs,std::string rd,std::string immen);
    void encode_register_register_instruction(std::string op,std::string rs,std::string rd);
    void encode_inmediate_instruction(std::string op,std::string rs,std::string imme);
    void encode_memory_instruction(std::string op,std::string rs,std::string tag);
    void encode_branch(std::string op,std::string tag);
    void encode_index_instruction(std::string op,std::string rd,std::string rs,std::string rs2,int type);
    void encode_post_index_instruction(std::string op,std::string rd,std::string rs,std::string rs2);
    std::string regtobin(std::string r);
    int indexOf(std::string tag);
    std::string immtobin(std::string in,int type,std::string rs);
    void procces_label(std::string tag,std::string g,int type);
    std::string current_type="DCD";
    int data_memory=0x10000000;
    int text_memory=0x00000000;
    void yyerror(std::string S);
    void printt(std::string s);


    bool isADD(std::string);
    bool isSUB(std::string);
    bool isCPT(std::string);
    bool isMUL(std::string);
    std::string getInstructionBinaryCode(std::string);



    void setInstructionCondition(std::string);
    void setInstructionOpCode(std::string);
    void setInstructionI(bool);
    void setInstructionCmd(std::string);
    void setInstructionMemoryFlags(bool,bool, bool, bool);
    void setInstructionS(bool);
    void setInstructionRn(std::string);
    void setInstructionRd(std::string);
    void setInstructionRm(std::string);
    void setInstructionRs(std::string);
    void setInstruction1L();
    void setInstructionJumpLabel(std::string);void setInstructionRd(std::string);
    void resetInstruction();void setInstructionRd(std::string);
    void writeInstruction();void setInstructionRd(std::string);
void setInstructionRd(std::string);


%}

%union{
  char* id;
  int num;
  char* modifier;
}
//lex tokens
%token <id> addition subtra multiple comp load store branch braneq branne mv point
%token <id> reg
%token <id> immediate
%token <id> label
%token <id> commentary
%token <num> number
%token <modifier> eq_modifier ne_modifier cs_modifier hs_modifier cc_modifier lo_modifier mi_modifier pl_modifier vs_modifier vc_modifier hi_modifier ls_modifier ge_modifier gt_modifier lt_modifier le_modifier al_modifier

//yacc tokens
//%type <id> operation
%%


body: line body | /*epsilon*/;

line: jump_tag tag_instruction documentation '\n';
jump_tag: label {procces_label($1,"",1);} | /*epsilon*/;
tag_instruction: instruction | /*Not instruction at the same line of the jump tag*/;
documentation: commentary | /*epsilon*/;

instruction: 
  {setInstructionOpCode(OPCODE_BRANCH);} 
  branch_operation operation_modifier label {writeInstruction(); resetInstruction();} /*Encode instruction*/
| {setInstructionOpCode(OPCODE_DATA);} 
  data_operation operation_modifier data_params
| {setInstructionOpCode(OPCODE_MEMORY);} 
  memory_operation operation_modifier memory_params
| {setInstructionOpCode(OPCODE_SPECIALIZED);} 
  specilized_operation operation_modifier specilized_params
;

branch_operation:
  branch {setInstruction1L();}
;


data_params:
  reg ',' reg ',' immediate /*{setInstructionRd($1);setInstructionRn($3);}*/
| reg ',' reg ',' reg /*{ setInstructionRd($1);setInstructionRn($3);setInstructionRm($5); }*/
;

memory_params:;

specilized_params:;

data_operation: 
  addition  {setInstructionCmd(BINARY_ADD_OPERATION);} 
| subtra    {setInstructionCmd(BINARY_SUB_OPERATION);}
| multiple  {setInstructionCmd(BINARY_MUL_OPERATION);}
| comp      {setInstructionCmd(BINARY_CMP_OPERATION);}
| mv        {setInstructionCmd(BINARY_MOV_OPERATION);}
;

memory_operation:
  store     {setInstructionMemoryFlags(false,false,false,false);}
| load      {setInstructionMemoryFlags(false,false,false,false);}
;


specilized_operation:
  point
;

/*
instruccion:  
  operation reg ',' reg  {std::cout << data_ins.cmd << std::endl;} {encode_register_register_instruction($1,$4,$2);}
| operation reg ',' immediate {encode_inmediate_instruction($1,$2,$4);}
| operation label {encode_branch($1,$2);}
| operation reg ',' '=' label  {encode_memory_instruction($1,$2,$5);}
| operation reg ',' reg ',' immediate {encode_register_inmediate_instruction($1,$4,$2,$6);}
| operation reg ',' '[' reg ']' {encode_index_instruction($1,$2,$5,"",1);}
| operation reg ',' '[' reg ',' reg ']' {encode_index_instruction($1,$2,$5,$7,2);}
| operation reg ',' '[' reg ',' immediate ']' {encode_index_instruction($1,$2,$5,$7,3);}
| operation reg ',' '[' reg ']' ',' immediate {encode_post_index_instruction($1,$2,$5,$8);}
| operation reg ',' '[' reg ',' immediate ']' '!' {encode_index_instruction($1,$2,$5,$7,4);}
| operation reg ',' reg ',' reg {encondig_instruccion($1,$4,$6,$2);}
| error {yyerror("2, instruccion wrong");}
;
*/

operation_modifier:  
  eq_modifier {setInstructionCondition(CONDITION_EQ);}
| ne_modifier {setInstructionCondition(CONDITION_NE);}
| cs_modifier {setInstructionCondition(CONDITION_CS);}
| hs_modifier {setInstructionCondition(CONDITION_HS);}
| cc_modifier {setInstructionCondition(CONDITION_CC);}
| lo_modifier {setInstructionCondition(CONDITION_LO);}
| mi_modifier {setInstructionCondition(CONDITION_MI);}
| pl_modifier {setInstructionCondition(CONDITION_PL);}
| vs_modifier {setInstructionCondition(CONDITION_VS);}
| vc_modifier {setInstructionCondition(CONDITION_VC);}
| hi_modifier {setInstructionCondition(CONDITION_HI);}
| ls_modifier {setInstructionCondition(CONDITION_LS);}
| ge_modifier {setInstructionCondition(CONDITION_GE);}
| gt_modifier {setInstructionCondition(CONDITION_GT);}
| lt_modifier {setInstructionCondition(CONDITION_LT);}
| le_modifier {setInstructionCondition(CONDITION_LE);}
| al_modifier {setInstructionCondition(CONDITION_AL);}
| /*NULL*/    {setInstructionCondition(CONDITION_AL);}
;

%%

extern int yyparse();
extern FILE *yyin;
std::string ruta="";



void setInstructionCondition(std::string condition){
  current_instruction.replace(0,4,condition);
}
void setInstructionOpCode(std::string opcode){
  current_instruction.replace(5,2,opcode);
}void setInstructionRd(std::string reg){
  
}
void setInstructionI(bool){
  
}
void setInstructionCmd(std::string cmd){
  current_instruction.replace(7,4,cmd);
}
void setInstructionMemoryFlags(bool,bool, bool, bool){
  
}
void setInstructionS(bool){
  
}
void setInstructionRn(std::string reg){
  current_instruction.replace(12, 4,regtobin(reg));
}
void setInstructionRd(std::string reg){
  current_instruction.replace(16, 4,regtobin(reg));
}
void setInstructionRm(std::string reg){
  current_instruction.replace(28, 4,regtobin(reg));
}
void setInstructionRs(std::string reg){
  current_instruction.replace(20, 4,regtobin(reg));
}
void setInstruction1L(){
  
}
void setInstructionJumpLabel(std::string){
  
}
void resetInstruction(){
  current_instruction = DEFAULT_INSTRUCTION;
  
}
void writeInstruction(){
  fs<<current_instruction<<'\n';
}



bool isADD(std::string op){
  return op.compare("Add")==0 || op.compare("ADD")==0 || op.compare("add")==0;
}   

bool isSUB(std::string op){
  return op.compare("Sub")==0 || op.compare("sub")==0 || op.compare("SUB")==0;
}
bool isCPT(std::string op){
  return op.compare("cpt")==0;
}
bool isMUL(std::string op){
  return op.compare("Mul")==0 || op.compare("MUL")==0 || op.compare("mul")==0;
}
std::string getInstructionBinaryCode(std::string op){
  if (isADD(op)) return BINARY_ADD_OPERATION;
  else if (isSUB(op)) return BINARY_SUB_OPERATION;
  else if (isCPT(op)) return BINARY_CPT_OPERATION;
  else if (isMUL(op)) return BINARY_MUL_OPERATION;
  else return BINARY_NIL_OPERATION;
}

//Instruccion op rd,rs,rm
void encondig_instruccion(std::string op,std::string rs,std::string rs2,std::string rd){
  //Setting cond as AL or NONE Always
  std::string binIns="1110";
  text_memory+=0x4;
  if(isADD(op) || isCPT(op) || isSUB(op)){
    //Adding operation
    binIns+=getInstructionBinaryCode(op);
    binIns+=regtobin(rs);
    binIns+=regtobin(rd);
    binIns+="00000000";
    binIns+=regtobin(rs2);
    fs<<binIns<<'\n';
  }
  else if(op.compare("Mul")==0 || op.compare("MUL")==0 || op.compare("mul")==0){
    binIns+="00000000";
    binIns+=regtobin(rd);
    binIns+="0000";
    binIns+=regtobin(rs2);
    binIns+="1001";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
    exit(-1);
  }
}

//Instruccion op rd,rs
void encode_register_register_instruction(std::string op,std::string rs,std::string rd){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("cmp")==0 || op.compare("CMP")==0 || op.compare("Cmp")==0){
    binIns+="00010101";
    binIns+=regtobin(rd);
    binIns+="000000000000";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else if(op.compare("mov")==0 || op.compare("MOV")==0 || op.compare("Mov")==0){
    binIns+="000110100000";
    binIns+=regtobin(rd);
    binIns+="00000000";
    binIns+=regtobin(rs);
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//Instruccion op rd,#imme
void encode_inmediate_instruction(std::string op,std::string rs,std::string imme){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("cmp")==0 || op.compare("CMP")==0 || op.compare("Cmp")==0){
    binIns+="00110101";
    std::string r=regtobin(rs);
    binIns+=r;
    binIns+="0000";
    binIns+=immtobin(imme,1,r);
    fs<<binIns<<'\n';
  }else if(op.compare("mov")==0 || op.compare("MOV")==0 || op.compare("Mov")==0){
    binIns+="001110100000";
    std::string r=regtobin(rs);
    binIns+=r;
    std::string inm=immtobin(imme,4,r);
    binIns+=inm;
    if(inm.compare("nop")!=0){
        fs<<binIns<<'\n';
    }
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//No implementadas correctamente, no realizan lo que deberian
void encode_memory_instruction(std::string op,std::string rs,std::string tag){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    binIns+="010100010000";
    binIns+=regtobin(rs);
    int result=labels.find(tag)->second;
    binIns+=std::bitset<12>(result).to_string();
    fs<<binIns<<'\n';
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    binIns+="010100000000";
    binIns+=regtobin(rs);
    int result=labels.find(tag)->second;
    binIns+=std::bitset<12>(result).to_string();
    fs<<binIns<<'\n';
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//Branch instruccion
void encode_branch(std::string op,std::string tag){
  text_memory+=0x4;
  if(op.compare("B")==0 || op.compare("b")==0){
    std::string binIns="11101010";
    int index=labels.find(tag)->second;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x14)/4;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    nop(5);
    text_memory+=0x10;
  }else if(op.compare("Beq")==0 || op.compare("BEQ")==0 || op.compare("beq")==0){
    std::string binIns="00001010";
    int index=labels.find(tag)->second;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x14)/4;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    nop(5);
    text_memory+=0x10;
  }else if(op.compare("Bne")==0 || op.compare("BNE")==0 || op.compare("bne")==0){
    std::string binIns="00011010";
    int index=labels.find(tag)->second;
    std::cout<<"label "<<tag<<" pos "<<index<<std::endl;
    if(index < 0){
      futureLabels[tag]=fs.tellp();
    }
    int result=(index-text_memory+0x14)/4;
    std::cout<<"the result of branch "<< result <<std::endl;
    binIns+=std::bitset<24>(result).to_string();
    fs<<binIns<<'\n';
    nop(5);
    text_memory+=0x10 ;
  }else{
    std::cout<< "Error at read instruccion: 2"<<'\n';
  }
}

//intruccion op rd,[rs,rm]
//          op rd,[rs,#imme] (post index and offset)
void encode_index_instruction(std::string op,std::string rd,std::string rs,std::string rs2,int type){
  std::string binIns="111001";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    if(type==1){
      binIns+="111001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="000000000000";
      fs<<binIns<<'\n';
      nop(3);
      text_memory+=0xC;
    }else if(type==2){
      binIns+="011001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="00000000";
      binIns+=regtobin(rs2);
      fs<<binIns<<'\n';
      nop(3);
      text_memory+=0xC;
    }else if(type==3){
      if(rs2.find("-")==std::string::npos){
        binIns+="111001";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
        nop(3);
        text_memory+=0xC;
      }else{
        rs2.erase(1,1);
        binIns+="110001";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
        nop(3);
        text_memory+=0xC;
      }
    }else if(type==4){
      if(rs2.find("-")==std::string::npos){
        binIns+="111011";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
        nop(3);
        text_memory+=0xC;
      }else{
        rs2.erase(1,1);
        binIns+="110011";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
        nop(3);
        text_memory+=0xC;
      }
    }
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    if(type==1){
      binIns+="111000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="000000000000";
      fs<<binIns<<'\n';
    }else if(type==2){
      binIns+="011000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+="00000000";
      binIns+=regtobin(rs2);
      fs<<binIns<<'\n';
    }else if(type==3){
      if(rs2.find("-")==std::string::npos){
        binIns+="111000";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
      }else{
        rs2.erase(1,1);
        binIns+="110000";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
      }
    }else if(type==4){
      if(rs2.find("-")==std::string::npos){
        binIns+="111010";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
      }else{
        rs2.erase(1,1);
        binIns+="110010";
        binIns+=regtobin(rs);
        binIns+=regtobin(rd);
        binIns+=immtobin(rs2,2,"");
        fs<<binIns<<'\n';
      }
    }
  }
}

//Instruccion op rd,[rs],#imme (post index)
void encode_post_index_instruction(std::string op,std::string rd,std::string rs,std::string rs2){
  std::string binIns="111001";
  text_memory+=0x4;
  if(op.compare("ldr")==0 || op.compare("Ldr")==0 || op.compare("LDR")==0){
    if(rs2.find("-")==std::string::npos){
      binIns+="101001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2,"");
      fs<<binIns<<'\n';
      nop(3);
      text_memory+=0xC;
    }else{
      rs2.erase(1,1);
      binIns+="100001";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2,"");
      fs<<binIns<<'\n';
      nop(3);
      text_memory+=0xC;
    }
  }else if(op.compare("str")==0 || op.compare("Str")==0 || op.compare("STR")==0){
    if(rs2.find("-")==std::string::npos){
      binIns+="101000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2,"");
      fs<<binIns<<'\n';
    }else{
      rs2.erase(1,1);
      binIns+="100000";
      binIns+=regtobin(rs);
      binIns+=regtobin(rd);
      binIns+=immtobin(rs2,2,"");
      fs<<binIns<<'\n';
    }
  }
}

//intruccion  op rd,rs,#imme
void encode_register_inmediate_instruction(std::string op,std::string rs,std::string rd,std::string immen){
  std::string binIns="1110";
  text_memory+=0x4;
  if(op.compare("Add")==0 || op.compare("ADD")==0 || op.compare("add")==0){
    binIns+="00101000";
    std::string r=regtobin(rs);
    binIns+=r;
    binIns+=regtobin(rd);
    binIns+=immtobin(immen,1,r);
    fs<<binIns<<'\n';
  }else if(op.compare("Sub")==0 || op.compare("sub")==0 || op.compare("SUB")==0){
    binIns+="00100100";
    std::string r=regtobin(rs);
    binIns+=r;
    binIns+=regtobin(rd);
    binIns+=immtobin(immen,1,r);
    fs<<binIns<<'\n';
  }
}

//Conversion del numero de registro a binario
std::string regtobin(std::string r){
  r.erase(0,1);
  std::string bin=std::bitset<4>(atoi(r.c_str())).to_string();
  return bin;
}

void procces_label(std::string tag,std::string g,int type){
  int tmp=futureLabels.find(tag)->second;
  if(tmp > 0){ //Se encontro una etiqueta usada por una instruccion antes de declararse
    int tposition=fs.tellp();
    int result=0x8+(0x4*tmp/33);
    std::cout<<tag<<" "<<result<<" "<<text_memory<<'\n';
    result=(text_memory-result)/4;
    fs.seekp(tmp+8);
    fs<<std::bitset<24>(result).to_string();
    fs.seekp(tposition);
  }

  if(type==1){
    labels[tag]=text_memory; //Valor de la etiqueta
  }else if(type==2){
    current_type=g;
    labels[tag]=data_memory;
  }
}

//Se guarda el inmediato en binario
//Type= De que tamaño sera el inmediato
std::string immtobin(std::string in,int type,std::string rs){
  in.erase(0,1);
  int x=0;
  if(in.find("0x")==std::string::npos){
    x=strtol(in.c_str(),NULL,10);
  }else{
    x=strtol(in.c_str(),NULL,16);
  }

  if(type==1){
    if(x<4096){
      std::string bin=std::bitset<12>(x).to_string();
      return bin;
    }else{
      while(x>4096){
        x=x-4095;
        std::string ins="111000101000";
        ins+=rs;
        ins+=rs;
        ins+="111111111111";
        fs<<ins<<'\n';
        text_memory+=0x4;
      }
      std::string bin=std::bitset<12>(x).to_string();
      return bin;
    }
  }else if(type==2){
    std::string bin=std::bitset<12>(x).to_string();
    return bin;
  }else if(type==3){
    std::string bin=std::bitset<24>(x).to_string();
    return bin;
  }else if(type==4){
    if(x<4096){
      std::string bin=std::bitset<12>(x).to_string();
      return bin;
    }else{
      x=x-4095;
      std::string ins="1110001110100000";
      ins+=rs;
      ins+="111111111111";
      fs<<ins<<'\n';
      while(x>4096){
        x=x-4095;
        ins="111000101000";
        ins+=rs;
        ins+=rs;
        ins+="111111111111";
        fs<<ins<<'\n';
        text_memory+=0x4;
      }
      ins="111000101000";
      ins+=rs;
      ins+=rs;
      ins+=std::bitset<12>(x).to_string();
      fs<<ins<<'\n';
      std::string bin="nop";
      return "nop";
    }
  }
}


void nop(int nopCount){
  for(int x = 0; x < nopCount;x++){
    fs<<NOP_INSTRUCTION<<'\n';
  }
}

void printt(std::string s){
  std::cout << s << std::endl;
}

void yyerror(std::string S){
  final_message="Compiler failed";
  std::cout << S <<" at line: "<<yylineno<<'\n';
}

int main(int argc, char ** argv) {
  if (argc != 3){
    std::cout << "Debe ingresar el nombre del codigo fuente en ensamblador y luego el archivo de destino " << std::endl;
    std::cout << "Ejemplo: ./arm-compiler source.s dest.txt" << std::endl;
    return -1;
  }
  fs.open (argv[2], std::ios::out | std::ios::trunc); //Intrucciones
  //fs2.open (argv[2], std::ios::out | std::ios::trunc); //Datos
  //std::cin>>ruta;
  FILE *myfile = fopen(argv[1], "r");
	//se verifica si es valido
	if (!myfile) {
		std::cout << "No es posible abrir el archivo" << std::endl;
		return -1;
	}
  nop(0);
	yyin = myfile;
	do {
		yyparse();
	} while (!feof(yyin));
  fs.close();
  //fs2.close();
  std::cout<<final_message<<'\n';
  for(int i=0;i<100;++i);
}
