IMPORT $;

$.File_NamesPhones.File;
$.File_NamesPhonesUpd.File;

COUNT($.File_NamesPhonesUpd.File);
BUILD($.File_NamesPhonesUpd.IDX_Fkey_RecID, OVERWRITE);
COUNT($.File_NamesPhonesUpd.IDX_Fkey_RecID);