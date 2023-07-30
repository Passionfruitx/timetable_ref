Header (
	company("EMA Design Automation") 
	product("TimingDesigner") 
	rev("9.2") 
	file("d:\\ref\\rc_full.td") 
	date("07/30/2023") time("19:02") 
	format("9.0") 
	baseScale(1000.000000) 
	zoomFactor("0.000592298") 
	zoomBegin(0) 
	zoomEnd(507976) 
	nameFrameWidth(291) 
	simHDL(Verilog) 
	simDelayMechanism(Transport) 
	nextID(24) 
	TimingAnalysisMethod(51) 
	SDCVersion(0) 
	
	generalPrintParams( "printer,,,portrait,jpg,Letter,default,6,5,in,color,scaleable,")
	diagramPrintParams( "0,5,0,300000,true,true,1,1,true,false,false,true,all,diagramEnd")
	spreadsheetPrintParams( "0,2147483647,true,false,1,true,all")
	)
tclPreferences (UseAboveSixtyFiveNm UseAlteraFastTimingModel 
	UseActelMaxTimingModel UseTimingPath UseArrivalTime )
HDLHeader( 
	hdlFile("") 
	checkConstraints(true) 
	comment("") 
	checkTimeout(never) 
	
	command( name("rw_reg") cmdType(null) ))
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
Bus ( objectID(8) name("CPU_ADDR") minheight("0") edges(
	(invalid,0.000,0.000,L), 
	(valid,40000.000,40000.000,label(showText,"WADDR","") ), 
	(invalid,190000.000,190000.000), 
	(blank,300000.000,300000.000)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Clock ( objectID(2) name("clk_50m") minheight("0") periodScale(1000.000) period(20.000000) dutyCycle(50.000000) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(3) name("rst_core_n") minheight("0") edges(
	(high,0.000,0.000,L), 
	(blank,300000.000,300000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(4) name("cpu_r_en") minheight("0") edges(
	(low,0.000,0.000,L), 
	(high,100000.000,100000.000), 
	(low,120000.000,120000.000), 
	(blank,300000.000,300000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Waveform ( objectID(14) name("inside_w_en") minheight("0") edges(
	(low,0.000,0.000,L), 
	(high,20000.000,20000.000), 
	(low,40000.000,40000.000), 
	(high,60000.000,60000.000), 
	(low,80000.000,80000.000), 
	(blank,300000.000,300000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Bus ( objectID(5) name("reg_field") minheight("0") edges(
	(valid,0.000,0.000,L,label(showText,"FULL","") ), 
	(valid,120000.000,120000.000,label(showText,"RST","") ), 
	(blank,300000.000,300000.000,T)) 
	hdl( direction(internal) ) label(showDefault,"","H") )
Grid ( "clk_50m" topWave("clk_50m") 
	 color(6) 1stWidth(0) 2ndWidth(0) 1stStyle(0) 2ndStyle(0) 
  show1st )

CauseAndEffect(objectID(23) source("cpu_r_en",1) target("reg_field",1) label(showDefault,"") fromLatestEnd toEarliestBegin color(3) width("0")  )
EndCycleEvent ( objectID(1) name("end") time(300.000000) showVert hideOnPrinter label(showDefault,"") fromLatestEnd toEarliestBegin  )
