FUNCTION ETA_CALC,t, lumin_params

	;PARA MI MEMORIA: LUM_PARAMS=[tau_sn,Mdm,z_*,little_h,t_start]
	t_start = lumin_params[4]

	H_0 = 7.48609e-11;yr^-1

	t_for_eta = t*t_start + t_start
	;print,'t for eta is ',t_for_eta
	z_eta = complete_t_to_z(t_for_eta)
	;print,'z_eta is ',z_eta

	H_now = H_0*sqrt(0.238*(1.0+z_eta)^3.0 + 0.762)
	H_scale2 = (2.0/3.0)/(lumin_params[4]) 
	retval = H_now/H_scale2

	return,retval
END
