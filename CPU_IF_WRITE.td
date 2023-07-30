Header (
	company("EMA Design Automation") 
	product("TimingDesigner") 
	rev("9.2") 
	file("d:\\ref\\cpu_if_write.td") 
	date("07/30/2023") time("19:00") 
	format("9.0") 
	baseScale(1000.000000) 
	zoomFactor("0.000594364") 
	zoomBegin(0) 
	zoomEnd(506656) 
	nameFrameWidth(291) 
	grayHidden 
	simHDL(Verilog) 
	simDelayMechanism(Transport) 
	nextID(186) 
	TimingAnalysisMethod(51) 
	SDCVersion(0) 
	
	generalPrintParams( "printer,,,portrait,jpg,Letter,default,6,5,in,color,scaleable,")
	diagramPrintParams( "0,17,0,500000,true,true,1,1,true,false,false,true,all,diagramEnd")
	spreadsheetPrintParams( "0,2147483647,true,false,1,true,all")
	)
tclPreferences (UseAboveSixtyFiveNm UseAlteraFastTimingModel 
	UseActelMaxTimingModel UseTimingPath UseArrivalTime )
HDLHeader( 
	hdlFile("") 
	checkConstraints(true) 
	comment("") 
	checkTimeout(never) 
	
	command( name("cpu_if_spt_read") cmdType(null) ))
DefaultLabel(
	delay(showNameString,"") 
	constraint(showNameString,"") 
	guarantee(showNameString,"") 
	measure(showMeasure,"") 
	store(showNameString,"") 
	wait(showNameString,"") 
	end(showNameString,"") 
	boundary(showIncrement,"") 
	loop(showNameString,"") 
	waveform(showSkip,"","") 
	specifiedclock(showSkip,"","") 
	derivedclock(showSkip,"","") 
	simwaveform(showSkip,"","") 
	bus(showValue,"","H") 
	)
DiagramStyle (
	waveformFont(winFont("Arial",90) qtFont("Arial",9) ) 
	rulerFont(winFont("Arial",90) qtFont("Arial",9) ) 
	relationshipFont(winFont("Arial",90) qtFont("Arial",9) ) 
	labelFont(winFont("Arial",90) qtFont("Arial",9) ) 
	annotationFont(winFont("Arial",80) qtFont("Arial",8) ) 
	slotHeight("11") 
	edgeHeight("11") 
	edgeGrade("1.96261") 
	inputPenStyle(0) 
	outputPenStyle(0) 
	inoutPenStyle(0) 
	internalPenStyle(0) 
	vRelationshipPenStyle(0) 
	hRelationshipPenStyle(0) 
	inputPenColor(3) 
	outputPenColor(3) 
	inoutPenColor(3) 
	internalPenColor(3) 
	wavePenWidth("0") 
	relationshipPenWidth("0") 
	wavesOnTop 
	relationshipsOnTop 
	annotationsOnTop 
	showSlopedEdges 
	edgeDisplayType(Uncertainty) 
	)
Bus ( objectID(3) name("CPU_ADDR") minheight("0") edges(
	(invalid,0.000,0.000,L), 
	(valid,80000.000,80000.000,label(showText,"MODE_SEL_ADDR","") ), 
	(invalid,211000.000,211000.000), 
	(blank,500000.000,500000.000)) 
	hdl( direction(input) ) label(showDefault,"","H") )
Waveform ( objectID(4) name("CPU_CS_N") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,80000.000,80000.000), 
	(high,200000.000,200000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(input) ) label(showDefault,"","H") )
Waveform ( objectID(5) name("CPU_WE_N") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,90000.000,90000.000), 
	(high,190000.000,190000.000), 
	(low,380000.000,380000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(input) ) label(showDefault,"","H") )
Bus ( objectID(56) name("CPU_RDATA[31:0]") minheight("0") edges(
	(invalid,0.000,0.000,L), 
	(valid,86000.000,86000.000,label(showText,"WDATA[31:0]","") ), 
	(invalid,216000.000,216000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Clock ( objectID(2) name("clk_50m") minheight("0") periodScale(1000.000) period(20.000000) dutyCycle(50.000000) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(9) name("rst_core_n") minheight("0") edges(
	(high,0.000,0.000,L), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(8) name("cpu_cs_n_reg0") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,100000.000,100000.000), 
	(high,220000.000,220000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(10) name("cpu_cs_n_reg1") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,120000.000,120000.000), 
	(high,240000.000,240000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(13) name("cpu_we_n_reg0") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,100000.000,100000.000), 
	(high,200000.000,200000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(14) name("cpu_we_n_reg1") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,120000.000,120000.000), 
	(high,220000.000,220000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(15) name("cpu_we_n_reg2") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,140000.000,140000.000), 
	(high,240000.000,240000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(16) name("cpu_we_n_reg3") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,160000.000,160000.000), 
	(high,260000.000,260000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(121) name("cpu_we_n_reg4") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,180000.000,180000.000), 
	(high,280000.000,280000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
SimWaveform ( objectID(138) name("cpu_rdy_oe_n") minheight("0") edges(
	(high,0.000,0.000,L), 
	(low,120000.000,120000.000,L), 
	(high,280000.000,280000.000,L), 
	(blank,500000.000,500000.000,L)) 
	hdl( direction(internal) calcInit ) 
	Equation("cpu_we_n_reg1 & cpu_we_n_reg4") Delays( toL("[,,]") toH("[,,]") propDelay("[,,]") ) label(showDefault,"","H") )
SimWaveform ( objectID(143) name("cpu_rdy_n") minheight("0") edges(
	(low,0.000,0.000,L), 
	(high,120000.000,120000.000,L), 
	(low,180000.000,180000.000,L), 
	(high,220000.000,220000.000,L), 
	(low,280000.000,280000.000,L), 
	(blank,500000.000,500000.000,L)) 
	hdl( direction(internal) calcInit ) 
	Equation("cpu_we_n_reg1 ^ cpu_we_n_reg4") Delays( toL("[,,]") toH("[,,]") propDelay("[,,]") ) label(showDefault,"","H") )
Waveform ( objectID(17) name("CPU_RDY_N") minheight("0") edges(
	(z,0.000,0.000,L), 
	(high,120000.000,120000.000), 
	(low,180000.000,180000.000), 
	(high,220000.000,220000.000), 
	(z,280000.000,280000.000), 
	(blank,500000.000,500000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
SimWaveform ( objectID(50) name("cpu_w_en") minheight("0") edges(
	(low,0.000,0.000,L), 
	(high,120000.000,120000.000,L), 
	(low,140000.000,140000.000,L), 
	(blank,500000.000,500000.000,L)) 
	hdl( direction(internal) calcInit ) 
	Equation("~cpu_we_n_reg1 & cpu_we_n_reg2 & ~cpu_cs_n_reg1") Delays( toL("[,,]") toH("[,,]") propDelay("[,,]") ) label(showDefault,"","H") )
Bus ( objectID(61) name("reg_field") minheight("0") edges(
	(valid,0.000,0.000,L), 
	(valid,160000.000,160000.000,label(showText,"WDATA[31:0]","") ), 
	(blank,500000.000,500000.000)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Grid ( "clk_50m" 
	 color(6) 1stWidth(0) 2ndWidth(0) 1stStyle(0) 2ndStyle(0) 
  show1st )

CauseAndEffect(objectID(109) source("cpu_w_en",2) target("reg_field",1) label(showDefault,"") fromLatestEnd toEarliestBegin color(3) width("0")  )

CauseAndEffect(objectID(133) source("cpu_w_en",2) target("reg_field",1) label(showDefault,"") fromLatestEnd toEarliestBegin color(3) width("0")  )
EndCycleEvent ( objectID(1) name("end") time(500.000000) showVert hideOnPrinter label(showDefault,"") fromLatestEnd toEarliestBegin  )
Delay ( value("[,,]") 
	instance(objectID(6) source("CPU_CS_N",1) target("CPU_WE_N",1) label(showText,"Tcas") fromLatestBegin toLatestEnd  )
	instance(objectID(11) source("CPU_CS_N",2) target("CPU_WE_N",2) label(showText,"Tcah") fromLatestBegin toLatestEnd  ))
Measure ( value("[180,,180]") 
	instance(objectID(12) source("CPU_WE_N",2) target("CPU_WE_N",3) MeasureValue("[180,,180]") label(showText,"Tcwh") fromLatestEnd toEarliestBegin bottom  ))
Delay ( value("[,,]") 
	instance(objectID(18) source("CPU_CS_N",1) target("CPU_RDY_N",1) label(showText,"Tcdch") fromLatestBegin toLatestEnd  )
	instance(objectID(48) source("CPU_CS_N",2) target("CPU_RDY_N",4) label(showText,"Tcdrt") fromLatestBegin toLatestEnd  ))
Delay ( value("[,,]") 
	instance(objectID(19) source("CPU_WE_N",1) target("CPU_RDY_N",2) label(showText,"Tcdwd") fromLatestBegin toLatestEnd  )
	instance(objectID(20) source("CPU_WE_N",2) target("CPU_RDY_N",2) label(showText,"Tcrw") fromLatestBegin toLatestEnd  )
	instance(objectID(47) source("CPU_WE_N",2) target("CPU_RDY_N",3) label(showText,"Twdrh") fromLatestBegin toLatestEnd slot(2)  ))
