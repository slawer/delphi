unit uDBservice3Job;

interface
uses
  Windows, SysUtils, registry, IniFiles, Math, Classes, uAbstrArray, uKRSfunctionv3,
  uMainData, uExportXLSConst, uExportLASconst, uCoderDosWin1;

type
  TcheckCondition = class
  public
    bError: boolean;
    bCreate, bWork: boolean;
    dtCreate_ot, dtCreate_do, dtWork_ot, dtWork_do: TDateTime;
    sMestoRozhd, sKust, sSkvazhina, sZadanie:          string;
    bMestoRozhd, bKust, bSkvazhina, bZadanie:         boolean; // Флаг поиска с 1-й позиции
  end;

  dbDBservice3Job = class(prqTTaskObject)
  private

  public

    project:      prqTKRS_ProjDescript2; // Описание текущего проекта
    jobExport:    prqTExpJob;
    jobExportLas: prqTExpLassJob;
    coder:        prqTCoderDosWin1;

    parCFG:       prqTKRS_Cfg6;
    projects:     prqTKRS_ProjTree;     // Описание дерева проектов
    treeClone:    prqTKRS_ProjTree;     // Рабочая копия проектов

    constructor Create;
    destructor  Destroy; override;
  end;


implementation

{ dbDBservice3Job }

constructor dbDBservice3Job.Create;
begin
  inherited;

  project      := prqTKRS_ProjDescript2.Create;
  jobExport    := prqTExpJob.Create;
  jobExportLas := prqTExpLassJob.Create;
  coder        := prqTCoderDosWin1.Create;

  parCFG       := prqTKRS_Cfg6.Create;
  projects     := prqTKRS_ProjTree.Create;
  treeClone    := prqTKRS_ProjTree.Create;
end;

destructor dbDBservice3Job.Destroy;
begin
  project.Free;
  jobExport.Free;
  jobExportLas.Free;
  coder.Free;
  parCFG.Free;
  projects.Free;
  treeClone.Free;
  inherited;
end;

end.
