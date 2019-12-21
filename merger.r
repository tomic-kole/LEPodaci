####DATA MERGER FUNKCIJA ZA LAKSE STAPANJE PODATAKA####

#ova funkcija pravi vektor imena fajlova koje treba procitati
.imena_fajlova<-function(ime, br_ispitanika, ekstenzija)
{
  o=paste(ime, br_ispitanika, ekstenzija, sep = "")
  return(o)
}

#Glavna funkcija. U argument "ime" treba upisati niz slova koji ide na pocetku
#svakog fajla. Argument "br_ispitanika" se odnosi na broj koji ide posle niza slova.
#Argument "ekstenzija" se odnosi na tip fajla u kom se nalaze podaci. Za sad se mogu
#uneti samo .csv i .txt, sto pokriva default ispise iz dva programa koje cesto koristimo
#MATLAB i OpenSesame. Argument "ima_header" je jasan. Tajni argument ".dbg" sam koristio
#pri konstruisanju programa i moze se koristiti pri dodavanju funkcionalnosti funkciji.
#Poslednja dva argumenta se u opstem slucaju daju ignorisati.
#PRIMER: u folderu imam fajlove: VLD1.csv, VLD2.csv, VLD3.csv . . . VLD70.csv
#        onda bi funkcija glasila:
#        moji_podaci <- merge(ime="VLD", br_ispitanika=1:70, ekstenzija=".csv")

merge<- function (ime = "", br_ispitanika, ekstenzija=c(".txt", ".csv"), subject_kolona = T, ima_header=T, .dbg=F)
{
imn=.imena_fajlova(ime, br_ispitanika, ekstenzija)
podaci=data.frame()
for (i in 1:length(imn)) {
if(.dbg){print(paste("čitam:",imn[i], collapse = ""))}
if(ekstenzija==".txt")
{dlm="\t"} else if (ekstenzija==".csv")
{dlm=","} else {print("podržane ekstenzije .csv i .txt")}

ovaj<-read.delim(imn[i], header = ima_header, sep = dlm)
if(subject_kolona){ovaj$subject<- rep(br_ispitanika[i], NROW(ovaj))}
podaci=rbind(podaci, ovaj)
}
return(podaci)
}

