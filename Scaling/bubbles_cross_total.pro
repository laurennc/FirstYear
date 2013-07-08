PRO BUBBLES_CROSS_TOTAL, grp_a, grp_b, radii_a, radii_b, OUTPUT=cross_out
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

keeping_count = fltarr(2,n_elements(grp_b[0,*]))
i = 0.0

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
				counting = counting + 1.0
                                ;print,'adding to count'
                                ;print,'counting inside',counting
			endif
		endelse
		k = k + 1.0
	endwhile
	;print,'counting is',counting
	keeping_count[*,i] = [i,counting]
	;print,keeping
	
	i = i+1.0
endwhile

cross_out = keeping_count
END
