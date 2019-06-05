# Replication Code for Shu (2019)
Shu, Chong 2019 "Endogenous Risk-Exposure and Systemic Instability".
<br/>
Paper available at <a href ='https://papers.ssrn.com/sol3/papers.cfm?abstract_id=3076076'> SSRN </a>

## Algorithm 

### Payment equilibrium
The payment equilibirum can be solved by "payment_solver.m". It is based on the algorithm first proposed by Eisenberg and Noe (2001). In particular, it solves the fixed point

<img src="latex/1.gif" >

### Network Distortion
The network distortion can be solved by "solver.m". It is intened to solve the network risk-taking distortion, first proposed by Shu (2019)

<img src="latex/2.gif" >

## Result

### Network Distortion for Ring/Complete/Lambda Network
	Ring_Complete.m
	
which gives us figure 4.(a)
	
<img src="figure/CompleteVSRing.jpg" style ="width:300px"/> 
	
### Equity Buffer	
	equity_buffer.m
	
	
which gives us figure 5

<img src="figure/equity.jpg" style ="width:300px"/> 

	
	
	
	
	
	
	
	
	