PRO SCALING_RELATIONS

;need to decide what variables to save when I go through the loop
;inputs
mass = [1.0e+]
f_sn = [0.001,0.01,0.1]
z_start = [12, 10, 8]

;end time I'll just send to the redshift of the simulation snapshot
z_end = 7.2895

i = 0

while (i < n_elements(mass)) do begin
	mass_in = mass[i]
	j = 0
	while (j < n_elements(f_sn)) do begin
		f_sn_in = f_sn[j]
		k = 0
		while (k < n_elements(z_start)) do begin
			z_start_in = z_start[k]

			sn_ode_calc,z_start_in,z_end,mass_in,f_sn_in,radii_out,time_out


;WRITE THE OUTPUT TO A FILE FOR PLOTTING LATER
			filein = 'scaling_'+str(mass_in)+'_'+str(f_sn_in)+'_'+str(t_start_in)+'.dat'
			openr,1,filein			
			count = 0
			while (count < n_elements(radii_out)) do begin
				output_line = [time_out[count], radii_out[count]]
				printf,1,output_line
				count = count + 1
			endwhile		
			close,1
			
		
			k = k + 1
		endwhile	
		j = j + 1
	endwhile
	i = i + 1
endwhile


