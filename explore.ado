*! version 1.0.0 15aug2017
program explore
	syntax , [ISID]
	loc categories : char _dta[explore]
	_assert "`categories'" != "", msg("Dataset not setup for explore")

	loc title : data label
	di as text "{title:Dataset}          {res}`title'"
	
	loc pk : char _dta[pk]
	di as text "{title:Identifiers}      {res}`pk'"
	if ("`isid'"!="") isid `pk'
	di as text "{title:Categories}       {res}<`categories'>"
	
	di as text _n "{title:Details}" _c
	_describe, short 
	

	loc allvars
	foreach cat of loc categories {
		loc vars : char _dta[`cat']
		_assert "`vars'" != "", msg("inspect error: category -`cat'- is empty")
		di as text _n "{title:`cat'}"
		loc 0 `vars'
		syntax varlist
		_describe `varlist', full
		di
		loc allvars `allvars' `varlist'
	}
	
	di as text _n "{bf:[Variables with no category]}"
	qui ds `allvars', not
	loc remainder `r(varlist)'
	_describe `remainder', full
	
end
