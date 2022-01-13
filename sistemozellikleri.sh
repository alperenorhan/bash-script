#!/bin/bash
#
function donanim_adi()
{
	yazi=$(uname -a)
	zenity --info --title 'Makine Donanım Adı' \
	--text "$yazi"  \
	--ok-label "Geri Dön" \
	--extra-button "Bilgileri Kaydet" --width=300 --height=100
	
	case $? in
    1)
        echo "$yazi" >> "donanim_adi.txt"
	;;
	esac
}

function makine_mimarisi()
{
    yazi=$(uname -m)
	zenity --info --title 'Makine Mimarisi' \
	--text "$yazi"  \
	--ok-label "Geri Dön"  --width=300 --height=100
	
	case $? in
    1)
        echo "$yazi" >> "makine_mimarisi.txt"
	;;
	esac
}

function islemci_ozellikleri()
{
    yazi=$(lscpu)
    echo "$yazi" > "islemci_ozellikleri.txt"
	zenity --text-info --title 'İşlemci Özellikleri' \
	--filename "islemci_ozellikleri.txt"  \
	--cancel-label "Geri Dön" \
	--ok-label "Çıkış Yap" \

	case $? in
     0)
	rc=0
	esac
}

function donanim_bilgisi()
{
	yazi=$(hwinfo --short)
	echo "$yazi" > "donanim_bilgisi.txt"
	zenity --text-info --title 'Donanım Bilgileri' \
	--filename "donanim_bilgisi.txt"  \
	--cancel-label "Geri Dön" \
	--ok-label "Çıkış Yap" --width=500 --height=500
	
	case $? in
    0)
        rc=0
	esac
}

function pci_bus()
{
	yazi=$(lspci)
	echo "$yazi" > "pci_bus.txt"
	zenity --text-info --title 'PCI Busları' \
	--filename "pci_bus.txt"  \
	--cancel-label "Geri Dön" \
	--ok-label "Çıkış Yap" --width=700 --height=350
	
	case $? in
    0)
        rc=0
	esac
}



rc=1
while [ $rc -eq 1 ]; do
  ans=$(zenity --info --title 'Linux Bilgilendirme Ekranı' \
      --text "Hangi bilgiyi görmek istersiniz?" --no-wrap \
      --extra-button "Makine Donanım Adı" \
      --extra-button "Makine Mimarisi" \
      --extra-button "İşlemci Özellikleri" \
      --extra-button "Donanım Bilgisi" \
      --extra-button "PCI Busları" \
      --ok-label "Çıkış Yap"
       )
  rc=$?
  echo "${rc}-${ans}"
  echo $ans
  if [[ $ans = "Makine Donanım Adı" ]]
  then
	donanim_adi
  elif [[ $ans = "Makine Mimarisi" ]]
  then
	makine_mimarisi
  elif [[ $ans = "İşlemci Özellikleri" ]]
  then
	islemci_ozellikleri
  elif [[ $ans = "Donanım Bilgisi" ]]
  then
	donanim_bilgisi
  elif [[ $ans = "PCI Busları" ]]
  then
	pci_bus
  fi
done
