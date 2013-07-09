FUNCTION SNRATE_WECHS, t,lumin_params

	;NOTE: TIME CONVERTED IN THE MASS_FUNCTION_TEST
	omega_b = 0.0416
	f_sn = lumin_params[6]
	tau_sf = 1e10; yrs

	value = (f_sn*omega_b*lumin_params[1])/tau_sf

return, value

END
