FUNCTION LUMINOSITY_SNWINDS_WECHS, t, r, v, q, lum_params;,h
	;PARA MI MEMORIA: LUM_PARAMS=[tau_sn,Mdm,z_*,little_h,t_start,L_scale]
	H_0 = 7.48609e-11;yr^-1
	
	snrate_here = snrate_wechs(t,lum_params)
	;h_scaled = h*lum_params[4]

	;lumin_calc = 1.0505838e-18 * snrate_here * h_scaled
	lumin_calc = 5.353919e-11*snrate_here	
	lumin_calc_scaled = lumin_calc/lum_params[5]

	;print,'lum used and scaled is ',lumin_calc_scaled
	return,lumin_calc_scaled
END




;THIS IS THE TEGMARK SOLUTION
	;f_m = 0.10
	;omega_b = 0.0416
	
	;eta = eta_calc(t,lum_params)
	;print,'inside tegmark!'
	;retval = 0.0
	
	;if ((t-lum_params[0]) lt 0.0) then begin
	;	print,'SNe on!
	;	retval = 1.0
	;endif
	
	;RIGHT NOW NOT INCLUDING DISSIPATION BECAUSE SCANNAPIECO DONT -- SOMETHING WE NEED TO DECIDE - ALSO GOOD UPPER LIMIT

	;print,'SNe turn dissipation!'
	;comp = 0.0045*(1.0/lum_params[3])*q*(r^3.0)*((1.0+z)^4.0)*(1.0+lum_params[2])^(-3.0/2.0)
	;ion = 2.2*f_m*omega_b*(omega_b*lum_params[1]/1e5)^(-2.0/5.0)*((eta*r)^2.0)*(v-(2.0/3.0)*eta*r)
	;diss = 0.0 ;for my choice of f_d = 0.0
	;retval = retval - comp - ion
	

	;return, retval
;END
