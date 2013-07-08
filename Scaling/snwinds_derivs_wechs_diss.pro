function snwinds_derivs_wechs_diss, t, vars, lumin_params
	;print,'vars input'
	;print,vars
	
	value1 = call_function('pressure_snwinds_wechs_diss',t,vars,lumin_params)
	value2 = call_function('radius_snwinds_wechs',t,vars,lumin_params)
	value3 = vars[1]
	value = [value1,value2,value3]


	;print,value,t
	return, value
end
