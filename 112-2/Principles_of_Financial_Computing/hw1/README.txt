Functions:
1. PV_cal & PV_cal_var:
	Evaluate PV using algorithm in lecture p.43. One is for fixed cash flows and the other is for variable cash flows.
2. Payment:
	Approximate fixed Cs using Bisection method (lecture p.60).
3. f_irr:
	Calculate PV with given rate, Cs, and F. We can't use PV_cal in this case because the cash flows are not fixed.
4. irr_cal:
	Approximate irr using Bisection method (lecture p.60), and compare the calcuated irr with r1 to determine whether swapping the loan lowers the IRR.

Main:
1. V, m, n1, r1, n2, r2, F:
	inputs.
2. epsilon, iterations:
	Set the tolerable discrepancies and the maximum iterations for approximation.
3. c1, c2, PV_n2:
	These variables are frequently used. Their definitions are as follows:
	(1) c1: regular payment of the original loan
	(2) c2: regular payment of the new loan
	(3) PV_n2: the remaining principal at the end of year n2.
4. outputs:
	An array stores outputs. PV(t) = the present value at period t.
	(1) outputs[0]: total principal paid in the first n2 years = PV(0) - PV(n2 * m)
	(2) outputs[1]: total interest paid in the first n2 years = c1 * (n2 * m) - (PV(0) - PV(n2 * m))
	(3) outputs[2]: total interest paid from the end of year n2 (excluded) to the end of year n1 if the loan is not swapped = c1 * ((n1 - n2) * m) - PV(n2 * m)
	(4) outputs[3]: total interest paid from the end of year n2 (excluded) to the end of year n1 if the loan is swapped = c2 * ((n1 - n2) * m) - PV(n2 * m)
	(5) outputs[4]: the approximation of the IRR for the whole n1 years (the fee F considered) if the loan is swapped. (Using Bisection method.)
	(6) outputs[5]: {1, 0, -1}
	
