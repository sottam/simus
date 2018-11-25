unit uVisualization;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, Grids, uvars;

type

  { TVisualization }

  TVisualization = class(TForm)
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    MemoryGrid: TStringGrid;
    UCLabel: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    SPHIGH: TLabel;
    SPLOW: TLabel;
    Label2: TLabel;
    PCLOW: TLabel;
    PCHIGH: TLabel;
    REM: TLabel;
    RDM: TLabel;
    RI: TLabel;
    REGSEMNOME: TLabel;
    ACC: TLabel;
    N_FLAG: TLabel;
    Z_FLAG: TLabel;
    C_FLAG: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MUXShape2: TShape;
    MUXShape1: TShape;
    ULAShape4: TShape;
    RDMShape: TShape;
    Shape11: TShape;
    Shape12: TShape;
    PCShape: TShape;
    SPShape: TShape;
    SEMNOMEShape: TShape;
    ACCShape: TShape;
    NShape: TShape;
    ZShape: TShape;
    CShape: TShape;
    ULAShape5: TShape;
    RIShape: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    MUXShape5: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;
    Shape37: TShape;
    Shape38: TShape;
    Shape39: TShape;
    MUXShape4: TShape;
    Shape40: TShape;
    Shape41: TShape;
    Shape42: TShape;
    Shape43: TShape;
    Shape44: TShape;
    Shape45: TShape;
    Shape46: TShape;
    Shape47: TShape;
    Shape48: TShape;
    Shape49: TShape;
    Shape50: TShape;
    Shape51: TShape;
    Shape52: TShape;
    Shape53: TShape;
    Shape54: TShape;
    Shape55: TShape;
    Shape56: TShape;
    Shape57: TShape;
    Shape58: TShape;
    Shape59: TShape;
    Shape60: TShape;
    Shape61: TShape;
    Shape62: TShape;
    Shape63: TShape;
    Shape64: TShape;
    Shape65: TShape;
    Shape66: TShape;
    Shape67: TShape;
    Shape68: TShape;
    Shape69: TShape;
    Shape7: TShape;
    Shape70: TShape;
    Shape71: TShape;
    Shape72: TShape;
    Shape73: TShape;
    Shape74: TShape;
    Shape75: TShape;
    Shape76: TShape;
    Shape8: TShape;
    REMShape: TShape;
    ULAShape1: TShape;
    ULAShape2: TShape;
    ULAShape3: TShape;
    MUXShape3: TShape;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Visualization: TVisualization;

implementation

{$R *.lfm}

{ TVisualization }

procedure TVisualization.FormCreate(Sender: TObject);
var
  i:integer;
begin
  for i := 0 to 65534 do
      begin
         MemoryGrid.Cells[0,i] := i.ToString();
         MemoryGrid.Cells[1,i] := memoria[i].toString();
      end;
end;

end.

