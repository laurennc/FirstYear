PRO METAL_WECHS,t,masses,yield,lumin_params,Z_stars,Z_book,metal_mass,star_mass,gas_mass;,del_starsarr,del_gasarr,del_Mdmarr

;t is an array of the times outputted by the integrator

omega_b = 0.0416
Z_stars = fltarr(n_elements(masses))
Z_book  = fltarr(n_elements(masses))
metal_mass = fltarr(n_elements(masses))
star_mass = fltarr(n_elements(masses))
gas_mass = fltarr(n_elements(masses))

;del_starsarr = fltarr(n_elements(masses))
;del_gasarr = fltarr(n_elements(masses))
;del_Mdmarr = fltarr(n_elements(masses))


time = t*lumin_params[4]+lumin_params[4]

i = 1.0

;OBVIOUSLY STARTS WITH SOME GAS MASS
gas_mass[0] = omega_b*masses[0]

while i lt n_elements(masses) do begin
;NEED TO MAKE SURE THAT I'M NOT FORMING STARS IF ALL OF THE GAS IS GONE
	del_t = time[i]-time[i-1.0]

	if (gas_mass[i-1.0] le 0.0) then begin
		del_stars = 0.0
	endif else begin
		del_stars = (0.99*gas_mass[i-1.0])/1e10	
		del_stars = del_t*del_stars
	
		if (del_stars gt gas_mass[i-1.0]) then begin
			del_stars = gas_mass[i-1.0]
		endif
	endelse

	
	del_metals = (yield - Z_stars[i-1.0])*del_stars
	del_Mdm = masses[i]-masses[i-1.0]
	
	metal_mass[i] = metal_mass[i-1.0] + del_metals
	star_mass[i] = star_mass[i-1.0] + del_stars
	gas_mass[i] = gas_mass[i-1.0] - del_stars + omega_b*del_Mdm
	;print,del_stars,omega_b*del_Mdm
	
	;unclear as to what del_gas is -- added gas - stars I guess?)
	del_book = (del_metals - Z_book[i-1.0]*del_Mdm*omega_b)/gas_mass[i]
	
	Z_stars[i] = metal_mass[i]/(gas_mass[i])
	Z_book[i]  = Z_book[i-1.0]+del_book
	
	;del_starsarr[i] = del_stars
	;del_gasarr[i] = omega_b*del_Mdm - del_stars
	;del_Mdmarr[i] = del_Mdm

	i = i + 1.0
endwhile


END

