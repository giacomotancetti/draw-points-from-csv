; il programma disegna una lista di punti leggendo le coordinate
; da un file .csv con la seguente struttura:
; coord_x;coord_y;coord_z;nome_punto

(setq dir (getfiled "Select a csv file" "c:/" "csv" 8))
(setq idf(open dir "r"))
(setq delimiter ";")
(setq h_testo "5.0")

(setq riga (read-line idf))

(while riga
	(setq len_str (strlen riga))
  	(setq i 1)
  	(setq l_delim (list))   ; la lista l_delim contiene tutte le posizioni dei delimitatori
  		 	        ; trovati nella riga i-esima
  	(repeat len_str	  
    		(setq char (substr riga i 1))
	  	(if (= char delimiter)
			(setq l_delim (cons i l_delim))
		  )	  
    		(setq i (+ i 1))
	  )
  
	(setq nome_pto (substr riga ( + (nth 0 l_delim) 1)))
	(setq x (substr riga 1 (- (nth 2 l_delim) 1)))
	(setq y (substr riga (+ (nth 2 l_delim) 1) (- (nth 1 l_delim) (+ (nth 2 l_delim) 1))))
	(setq z (substr riga (+ (nth 1 l_delim) 1) (- (nth 0 l_delim) (+ (nth 1 l_delim) 1))))

  	(setq coord (strcat x "," y "," z))
	(command "_point" coord)
  	(command "_text" coord h_testo "0.0" nome_pto)
  
  (setq riga (read-line idf))
  )
  
(close idf)


