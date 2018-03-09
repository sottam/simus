{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit FirmataPascal;

{$warn 5023 off : no warning about unused units}
interface

uses
  FirmataClient, FirmataConstants, LazarusPackageIntf;

implementation

procedure Register;
begin
end;

initialization
  RegisterPackage('FirmataPascal', @Register);
end.
