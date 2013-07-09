PRO SCALING_RELATIONS

!path=EXPAND_PATH('+/home/lauren/idl')+':'+!path

set_plot,'ps'
!p.font=0
device, helvetica=1, filename='r_m_sfr.eps',/encaps,/color
device, isolatin1=1
!p.thick=4
!x.thick=3
!y.thick=3


;need to decide what variables to save when I go through the loop
;inputs
mass = [1.0e+]
f_sn = [0.001,0.01,0.1]
z_start = [12, 10, 8]

;end time I'll just send to the redshift of the simulation snapshot
z_end = 7.2895


;before I go through the loops with the calculations, perhaps it would be best
;to just set up the plots instead of printing out all of the calculations...
colors=['tomato','lawn green','dodger blue']

plot,mass,mass,xrange=[5,9],yrange=[0,1.5],/nodata

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

			ntot = n_elements(radii_out)-1
			oplot,alog10(m),radii_out[ntot],psym=5,color=fsc_color(colors[j])

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

device,/close
set_plot,'x'

END



