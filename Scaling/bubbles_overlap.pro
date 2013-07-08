PRO BUBBLES_OVERLAP, grp_a, grp_b, radii_a, radii_b, NUMBER_CROSS=number_cross,dist_return,track_vol
;grp_a and grp_b should be the xyz positions of the particles in those groups.

;First, let's compute a distance matrix. Thus for any r_a - r_b[i] = rdist[*,i]
r_dists = findgen(n_elements(grp_a[0,*]),n_elements(grp_b[0,*]))
i = 0.0

while (i lt n_elements(grp_b[0,*])) do begin
	dists = sqrt( ((grp_a[0,*]-grp_b[0,i])^2.0) + ((grp_a[1,*]-grp_b[1,i])^2.0) + ((grp_a[2,*]-grp_b[2,i])^2.0) )
	r_dists[*,i] = dists
	i = i + 1.0
endwhile
dist_return = r_dists

keeping_count = fltarr(n_elements(grp_b[0,*]))
i = 0.0

;track_vol = fltarr(6,2315)
track_vol = fltarr(6,4784)
;track_vol = fltarr(6,738)
;track_vol = fltarr(6,80)
track_count = 0.0

while (i lt n_elements(grp_b[0,*])) do begin
	k = 0
	;print,'i is ',i
	counting = 0.0
	while (k lt n_elements(grp_a[0,*])) do begin
		if (grp_b[0,i] eq grp_a[0,k] AND grp_b[1,i] eq grp_a[1,k] AND grp_b[2,i] eq grp_a[2,k]) then begin
			;print,'here I am doing nothing'
		endif else begin
			r_diff = r_dists[k,i]
			;print,'r_diff is ',r_diff
			;print,r_diff,radii_b[i]+radii_a[k]
                        if (r_diff lt (radii_b[i]+radii_a[k])) then begin
				if i le k then begin
					counting = counting + 1.0

					;ADD THE VOLUME CALCULATION
					shared_vol = !pi*((radii_b[i]+radii_a[k]-r_diff)^2.0)*(r_diff^2.0 + 2.0*r_diff*(radii_b[i]+radii_a[k]) - 3.0*(radii_b[i]^2.0 + radii_a[k]^2.0) + 6.0*radii_b[i]*radii_a[k])
					shared_vol = shared_vol/(12.0*r_diff)
					vola = (4.0/3.0)*!pi*(radii_a[k])^3.0	
					volb = (4.0/3.0)*!pi*(radii_b[i])^3.0
					percent = (shared_vol)/(vola+volb)
					;print,'above the problem line. counting is ',counting
					print,'track_count: ',track_count				
					track_vol[*,track_count] = [i,k,shared_vol,volb,vola,percent]
					track_count = track_count + 1.0
				endif else begin
					;print,'hopefully getting rid of repeats'
				endelse
			endif
		endelse
		k = k + 1.0
	endwhile
	;print,'counting is',counting
	keeping_count[i] = counting
	
	i = i+1.0
endwhile

number_cross = keeping_count
END
