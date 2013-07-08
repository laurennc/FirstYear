PRO FIND_AC_WECHS,p10,uf_mass_grps,rs,cvir,ac
	number = n_elements(uf_mass_grps)
	i = 0.0

	rs = fltarr(number)
	cvir = rs & ac=rs

	while i lt number do begin
		rs_input = [p10.halos.halfmassr[uf_mass_grps[i]],p10.halos.outerr[uf_mass_grps[i]]]
		rs[i] = zbrent_winput(0.0,rs_input[1],rs_input,FUNC_NAME='find_nfw_rs',TOLERANCE=1e-6)
		cvir[i] = rs_input[1]/rs[i]
		ac[i] = (0.0909091*4.1)/cvir[i]
		i = i+1.0
	endwhile

END

