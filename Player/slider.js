function Range() {
	this._value = 0;
	this._minimum = 0;
	this._maximum = 100;
	this._extent = 0;
	
	this._isChanging = false;
}

Range.prototype.setValue = function (value) {
	value = parseInt(value);
	if (isNaN(value)) return;
	if (this._value != value) {
		if (value + this._extent > this._maximum)
			this._value = this._maximum - this._extent;
		else if (value < this._minimum)
			this._value = this._minimum;
		else
			this._value = value;
		if (!this._isChanging && typeof this.onchange == "function")
			 this.onchange();
	}
};

Range.prototype.getValue = function () {
	return this._value;
};

Range.prototype.setExtent = function (extent) {
	if (this._extent != extent) {
		if (extent < 0)
			this._extent = 0;
		else if (this._value + extent > this._maximum)
			this._extent = this._maximum - this._value;
		else
			this._extent = extent;
		if (!this._isChanging && typeof this.onchange == "function")
			this.onchange();
	}
};

Range.prototype.getExtent = function () {
	return this._extent;
};

Range.prototype.setMinimum = function (minimum) {
	if (this._minimum != minimum) {
		var oldIsChanging = this._isChanging;
		this._isChanging = true;

		this._minimum = minimum;
		
		if (minimum > this._value)
			this.setValue(minimum);
		if (minimum > this._maximum) {
			this._extent = 0;
			this.setMaximum(minimum);
			this.setValue(minimum)
		}
		if (minimum + this._extent > this._maximum)
			this._extent = this._maximum - this._minimum;

		this._isChanging = oldIsChanging;
		if (!this._isChanging && typeof this.onchange == "function")
			this.onchange();
	}
};

Range.prototype.getMinimum = function () {
	return this._minimum;
};

Range.prototype.setMaximum = function (maximum) {
	if (this._maximum != maximum) {
		var oldIsChanging = this._isChanging;
		this._isChanging = true;

		this._maximum = maximum;		
		
		if (maximum < this._value)
			this.setValue(maximum - this._extent);
		if (maximum < this._minimum) {
			this._extent = 0;
			this.setMinimum(maximum);
			this.setValue(this._maximum);
		}		
		if (maximum < this._minimum + this._extent)
			this._extent = this._maximum - this._minimum;
		if (maximum < this._value + this._extent)
			this._extent = this._maximum - this._value;
		
		this._isChanging = oldIsChanging;
		if (!this._isChanging && typeof this.onchange == "function")
			this.onchange();
	}
};

Range.prototype.getMaximum = function () {
	return this._maximum;
};

function Timer(nPauseTime) {
	this._pauseTime = typeof nPauseTime == "undefined" ? 1000 : nPauseTime;
	this._timer = null;
	this._isStarted = false;
}

Timer.prototype.start = function () {
	if (this.isStarted())
		this.stop();
	var oThis = this;
	this._timer = window.setTimeout(function () {
		if (typeof oThis.ontimer == "function")
			oThis.ontimer();
	}, this._pauseTime);
	this._isStarted = false;
};

Timer.prototype.stop = function () {
	if (this._timer != null)
		window.clearTimeout(this._timer);
	this._isStarted = false;
};

Timer.prototype.isStarted = function () {
	return this._isStarted;
};

Timer.prototype.getPauseTime = function () {
	return this._pauseTime;
};

Timer.prototype.setPauseTime = function (nPauseTime) {
	this._pauseTime = nPauseTime;
};

Slider.isSupported = typeof document.createElement != "undefined" &&
	typeof document.documentElement != "undefined" &&
	typeof document.documentElement.offsetWidth == "number";


function Slider(oElement, oInput, sOrientation) {
	if (!oElement) return;
	this._orientation = sOrientation || "horizontal";
	this._range = new Range();
	this._range.setExtent(0);
	this._blockIncrement = 10;
	this._unitIncrement = 1;
	this._timer = new Timer(100);


	if (Slider.isSupported && oElement) {

		this.document = oElement.ownerDocument || oElement.document;

		this.element = oElement;
		this.element.slider = this;
		this.element.unselectable = "on";

		// add class name tag to class name
		this.element.className = this._orientation + " " + this.classNameTag + " " + this.element.className;

		// create line
		this.line = this.document.createElement("DIV");
		this.line.className = "line";
		this.line.unselectable = "on";
		this.line.appendChild(this.document.createElement("DIV"));
		this.element.appendChild(this.line);

		// create handle
		this.handle = this.document.createElement("DIV");
		this.handle.className = "handle";
		this.handle.unselectable = "on";
		this.handle.appendChild(this.document.createElement("DIV"));
		this.handle.firstChild.appendChild(
			this.document.createTextNode(String.fromCharCode(160)));
		this.element.appendChild(this.handle);
	}

	this.input = oInput;

	// events
	var oThis = this;
	this._range.onchange = function () {
		oThis.recalculate();
		if (typeof oThis.onchange == "function")
			oThis.onchange();
	};

	if (Slider.isSupported && oElement) {
		this.element.onfocus		= Slider.eventHandlers.onfocus;
		this.element.onblur			= Slider.eventHandlers.onblur;
		this.element.onmousedown	= Slider.eventHandlers.onmousedown;
		this.element.onmouseover	= Slider.eventHandlers.onmouseover;
		this.element.onmouseout		= Slider.eventHandlers.onmouseout;
		this.element.onkeydown		= Slider.eventHandlers.onkeydown;
		this.element.onkeypress		= Slider.eventHandlers.onkeypress;
		this.element.onmousewheel	= Slider.eventHandlers.onmousewheel;
		this.handle.onselectstart	=
		this.element.onselectstart	= function () { return false; };

		this._timer.ontimer = function () {
			oThis.ontimer();
		};

		// extra recalculate for ie
		window.setTimeout(function() {
			oThis.recalculate();
		}, 1);
	}
	else {
		this.input.onchange = function (e) {
			oThis.setValue(oThis.input.value);
		};
	}
}

Slider.eventHandlers = {

	// helpers to make events a bit easier
	getEvent:	function (e, el) {
		if (!e) {
			if (el)
				e = el.document.parentWindow.event;
			else
				e = window.event;
		}
		if (!e.srcElement) {
			var el = e.target;
			while (el != null && el.nodeType != 1)
				el = el.parentNode;
			e.srcElement = el;
		}
		if (typeof e.offsetX == "undefined") {
			e.offsetX = e.layerX;
			e.offsetY = e.layerY;
		}

		return e;
	},

	getDocument:	function (e) {
		if (e.target)
			return e.target.ownerDocument;
		return e.srcElement.document;
	},

	getSlider:	function (e) {
		var el = e.target || e.srcElement;
		while (el != null && el.slider == null)	{
			el = el.parentNode;
		}
		if (el)
			return el.slider;
		return null;
	},

	getLine:	function (e) {
		var el = e.target || e.srcElement;
		while (el != null && el.className != "line")	{
			el = el.parentNode;
		}
		return el;
	},

	getHandle:	function (e) {
		var el = e.target || e.srcElement;
		var re = /handle/;
		while (el != null && !re.test(el.className))	{
			el = el.parentNode;
		}
		return el;
	},
	// end helpers

	onfocus:	function (e) {
		var s = this.slider;
		s._focused = true;
		s.handle.className = "handle hover";
	},

	onblur:	function (e) {
		var s = this.slider
		s._focused = false;
		s.handle.className = "handle";
	},

	onmouseover:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var s = this.slider;
		if (e.srcElement == s.handle)
			s.handle.className = "handle hover";
	},

	onmouseout:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var s = this.slider;
		if (e.srcElement == s.handle && !s._focused)
			s.handle.className = "handle";
	},

	onmousedown:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var s = this.slider;
		if (s.element.focus)
			s.element.focus();

		Slider._currentInstance = s;
		var doc = s.document;

		if (doc.addEventListener) {
			doc.addEventListener("mousemove", Slider.eventHandlers.onmousemove, true);
			doc.addEventListener("mouseup", Slider.eventHandlers.onmouseup, true);
		}
		else if (doc.attachEvent) {
			doc.attachEvent("onmousemove", Slider.eventHandlers.onmousemove);
			doc.attachEvent("onmouseup", Slider.eventHandlers.onmouseup);
			doc.attachEvent("onlosecapture", Slider.eventHandlers.onmouseup);
			s.element.setCapture();
		}

		if (Slider.eventHandlers.getHandle(e)) {	// start drag
			Slider._sliderDragData = {
				screenX:	e.screenX,
				screenY:	e.screenY,
				dx:			e.screenX - s.handle.offsetLeft,
				dy:			e.screenY - s.handle.offsetTop,
				startValue:	s.getValue(),
				slider:		s
			};
		}
		else {
			var lineEl = Slider.eventHandlers.getLine(e);
			s._mouseX = e.offsetX + (lineEl ? s.line.offsetLeft : 0);
			s._mouseY = e.offsetY + (lineEl ? s.line.offsetTop : 0);
			s._increasing = null;
			s.ontimer();
		}
	},

	onmousemove:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);

		if (Slider._sliderDragData) {	// drag
			var s = Slider._sliderDragData.slider;

			var boundSize = s.getMaximum() - s.getMinimum();
			var size, pos, reset;

			if (s._orientation == "horizontal") {
				size = s.element.offsetWidth - s.handle.offsetWidth;
				pos = e.screenX - Slider._sliderDragData.dx;
				reset = Math.abs(e.screenY - Slider._sliderDragData.screenY) > 100;
			}
			else {
				size = s.element.offsetHeight - s.handle.offsetHeight;
				pos = s.element.offsetHeight - s.handle.offsetHeight -
					(e.screenY - Slider._sliderDragData.dy);
				reset = Math.abs(e.screenX - Slider._sliderDragData.screenX) > 100;
			}
			s.setValue(reset ? Slider._sliderDragData.startValue :
						s.getMinimum() + boundSize * pos / size);
			return false;
		}
		else {
			var s = Slider._currentInstance;
			if (s != null) {
				var lineEl = Slider.eventHandlers.getLine(e);
				s._mouseX = e.offsetX + (lineEl ? s.line.offsetLeft : 0);
				s._mouseY = e.offsetY + (lineEl ? s.line.offsetTop : 0);
			}
		}

	},

	onmouseup:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var s = Slider._currentInstance;
		var doc = s.document;
		if (doc.removeEventListener) {
			doc.removeEventListener("mousemove", Slider.eventHandlers.onmousemove, true);
			doc.removeEventListener("mouseup", Slider.eventHandlers.onmouseup, true);
		}
		else if (doc.detachEvent) {
			doc.detachEvent("onmousemove", Slider.eventHandlers.onmousemove);
			doc.detachEvent("onmouseup", Slider.eventHandlers.onmouseup);
			doc.detachEvent("onlosecapture", Slider.eventHandlers.onmouseup);
			s.element.releaseCapture();
		}

		if (Slider._sliderDragData) {	// end drag
			Slider._sliderDragData = null;
		}
		else {
			s._timer.stop();
			s._increasing = null;
		}
		Slider._currentInstance = null;
	},

	onkeydown:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		//var s = Slider.eventHandlers.getSlider(e);
		var s = this.slider;
		var kc = e.keyCode;
		switch (kc) {
			case 33:	// page up
				s.setValue(s.getValue() + s.getBlockIncrement());
				break;
			case 34:	// page down
				s.setValue(s.getValue() - s.getBlockIncrement());
				break;
			case 35:	// end
				s.setValue(s.getOrientation() == "horizontal" ?
					s.getMaximum() :
					s.getMinimum());
				break;
			case 36:	// home
				s.setValue(s.getOrientation() == "horizontal" ?
					s.getMinimum() :
					s.getMaximum());
				break;
			case 38:	// up
			case 39:	// right
				s.setValue(s.getValue() + s.getUnitIncrement());
				break;

			case 37:	// left
			case 40:	// down
				s.setValue(s.getValue() - s.getUnitIncrement());
				break;
		}

		if (kc >= 33 && kc <= 40) {
			return false;
		}
	},

	onkeypress:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var kc = e.keyCode;
		if (kc >= 33 && kc <= 40) {
			return false;
		}
	},

	onmousewheel:	function (e) {
		e = Slider.eventHandlers.getEvent(e, this);
		var s = this.slider;
		if (s._focused) {
			s.setValue(s.getValue() + e.wheelDelta / 120 * s.getUnitIncrement());
			// windows inverts this on horizontal sliders. That does not
			// make sense to me
			return false;
		}
	}
};



Slider.prototype.classNameTag = "dynamic-slider-control",

Slider.prototype.setValue = function (v) {
	this._range.setValue(v);
	this.input.value = this.getValue();
};

Slider.prototype.getValue = function () {
	return this._range.getValue();
};

Slider.prototype.setMinimum = function (v) {
	this._range.setMinimum(v);
	this.input.value = this.getValue();
};

Slider.prototype.getMinimum = function () {
	return this._range.getMinimum();
};

Slider.prototype.setMaximum = function (v) {
	this._range.setMaximum(v);
	this.input.value = this.getValue();
};

Slider.prototype.getMaximum = function () {
	return this._range.getMaximum();
};

Slider.prototype.setUnitIncrement = function (v) {
	this._unitIncrement = v;
};

Slider.prototype.getUnitIncrement = function () {
	return this._unitIncrement;
};

Slider.prototype.setBlockIncrement = function (v) {
	this._blockIncrement = v;
};

Slider.prototype.getBlockIncrement = function () {
	return this._blockIncrement;
};

Slider.prototype.getOrientation = function () {
	return this._orientation;
};

Slider.prototype.setOrientation = function (sOrientation) {
	if (sOrientation != this._orientation) {
		if (Slider.isSupported && this.element) {
			// add class name tag to class name
			this.element.className = this.element.className.replace(this._orientation,
									sOrientation);
		}
		this._orientation = sOrientation;
		this.recalculate();

	}
};

Slider.prototype.recalculate = function() {
	if (!Slider.isSupported || !this.element) return;

	var w = this.element.offsetWidth;
	var h = this.element.offsetHeight;
	var hw = this.handle.offsetWidth;
	var hh = this.handle.offsetHeight;
	var lw = this.line.offsetWidth;
	var lh = this.line.offsetHeight;

	// this assumes a border-box layout

	if (this._orientation == "horizontal") {
		this.handle.style.left = (w - hw) * (this.getValue() - this.getMinimum()) /
			(this.getMaximum() - this.getMinimum()) + "px";
		this.handle.style.top = (h - hh) / 2 + "px";

		this.line.style.top = (h - lh) / 2 + "px";
		this.line.style.left = hw / 2 + "px";
		//this.line.style.right = hw / 2 + "px";
		this.line.style.width = Math.max(0, w - hw - 2)+ "px";
		this.line.firstChild.style.width = Math.max(0, w - hw - 4)+ "px";
	}
	else {
		this.handle.style.left = (w - hw) / 2 + "px";
		this.handle.style.top = h - hh - (h - hh) * (this.getValue() - this.getMinimum()) /
			(this.getMaximum() - this.getMinimum()) + "px";

		this.line.style.left = (w - lw) / 2 + "px";
		this.line.style.top = hh / 2 + "px";
		this.line.style.height = Math.max(0, h - hh - 2) + "px";	//hard coded border width
		//this.line.style.bottom = hh / 2 + "px";
		this.line.firstChild.style.height = Math.max(0, h - hh - 4) + "px";	//hard coded border width
	}
};

Slider.prototype.ontimer = function () {
	var hw = this.handle.offsetWidth;
	var hh = this.handle.offsetHeight;
	var hl = this.handle.offsetLeft;
	var ht = this.handle.offsetTop;

	if (this._orientation == "horizontal") {
		if (this._mouseX > hl + hw &&
			(this._increasing == null || this._increasing)) {
			this.setValue(this.getValue() + this.getBlockIncrement());
			this._increasing = true;
		}
		else if (this._mouseX < hl &&
			(this._increasing == null || !this._increasing)) {
			this.setValue(this.getValue() - this.getBlockIncrement());
			this._increasing = false;
		}
	}
	else {
		if (this._mouseY > ht + hh &&
			(this._increasing == null || !this._increasing)) {
			this.setValue(this.getValue() - this.getBlockIncrement());
			this._increasing = false;
		}
		else if (this._mouseY < ht &&
			(this._increasing == null || this._increasing)) {
			this.setValue(this.getValue() + this.getBlockIncrement());
			this._increasing = true;
		}
	}

	this._timer.start();
};

var vSlider = new Slider(volume,volumeSlider);
vSlider.setMinimum(0);
vSlider.setMaximum(100);
vSlider.onchange = function() { setVolume(vSlider.getValue()); }