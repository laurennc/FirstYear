PRO TRACK_TOTAL_STARMASS,time,masses,yield,star_mass,gas_mass,total_mass

;TIME SHOULD BE REAL VALUES
;start with z=12 and take steps of 1e6 years for the beginning end at z=10

omega_b = 0.0416
star_mass = fltarr(n_elements(time),n_elements(masses))
gas_mass = fltarr(n_elements(time),n_elements(masses))




;OBVIOUSLY STARTS WITH SOME GAS MASS
gas_mass[0,*] = omega_b*masses

k=0.0
while k lt n_elements(masses) do begin

	i = 1.0
	while i lt n_elements(time) do begin
	;NEED TO MAKE SURE THAT I'M NOT FORMING STARS IF ALL OF THE GAS IS GONE
		del_t = time[i]-time[i-1.0]

		if (gas_mass[i-1.0,k] le 0.0) then begin
			del_stars = 0.0
		endif else begin
			del_stars = (0.99*gas_mass[i-1.0,k])/1e10	
			del_stars = del_t*del_stars
	
			if (del_stars gt gas_mass[i-1.0]) then begin
				del_stars = gas_mass[i-1.0,k]
			endif
		endelse

		star_mass[i,k] = star_mass[i-1.0,k] + del_stars
		gas_mass[i,k] = gas_mass[i-1.0,k] - del_stars
	
		i = i + 1.0
	endwhile
	k = k+1.0
endwhile

total_mass = fltarr(n_elements(time))
j = 0.0
;print,n_elements(total_mass)
while j lt n_elements(time) do begin
	total_mass[j] = TOTAL(star_mass[j,*]) 
	;print,'j is ',j
	j = j + 1.0
endwhile



END

