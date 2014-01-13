FUNCTION SNRATE_WECHS, t,lumin_params;,a,n

	;NOTE: TIME CONVERTED IN THE MASS_FUNCTION_TEST
	omega_b = 0.0416
	;f_sn = 0.01
	f_sn = lumin_params[6]
	tau_sf = 1e10; yrs

	;func = 'wechs_mass'
	;value = call_function(func,t,lumin_params)

	;;;;;;;;;
	;THIS IS WHAT I HAD FOR MY FIRST ATTEMPT AT SCALING FOR SIMS
	;BUT I'VE BEEN PASSING IT STELLAR MASSES SO THIS IS WRONG
	;value = (f_sn*omega_b*value)/tau_sf
	;;;;;;;;;
	
	value = (f_sn*lumin_params[1])/tau_sf

return, value

END
