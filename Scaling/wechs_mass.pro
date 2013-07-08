FUNCTION WECHS_MASS,t,lumin_params
	;NOTE: a_c is lumin_params[6]

	time_here = t*lumin_params[4] + lumin_params[4]
	z_here = complete_t_to_z(time_here)
	a_here = 1.0/(1.0+z_here)
	;print,'a_here is ',a_here
	exp_val = -2.0*lumin_params[6]*( (0.0909091/a_here) - 1.0)
	;print,'exp_val is ',exp_val
	retval = lumin_params[1]*exp(exp_val)
	
	;do I ever update the lumin params?! I'm pretty sure I don't... can always check by running the code and then printing them afterwards...

	RETURN, retval
END
