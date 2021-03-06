// JavaScript Document
!function(a, b) {
	"function" == typeof define && define.amd ? define(["$"], b) : "object" == typeof exports ? module.exports = b() : a.Calendar = b(window.Zepto || window.jQuery || $)
}(this, function(a) {
	a.fn.Calendar = function(c) {
		var d = [];
		return a(this).each(function() {
			var e = new b,
				f = a.extend({
					target: a(this)
				}, c);
			e.init(f), d.push(e)
		}), d
	};
	var b = function() {
			this.monthArr = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"], this.dayArr = ["日", "一", "二", "三", "四", "五", "六"];
			var a = Math.random().toString().replace(".", "");
			this.id = "calendar_" + a, this.calendarContainer, this.settings = {}, this.isShow = !1, this.autohide = !0, this.toolbarTpl = '<div class="ui-calendar-toolbar clearfix"><a class="js-calendar-submit">确定</a><a class="ui-calendar-today">今天</a><a class="js-clear">清空</a><a class="ui-calendar-close">关闭</a></div>', this.timeTpl = '<div class="ui-calendar-time clearfix"><select class="js-calendar-hours">时</select>:<select class="js-calendar-minutes">分</select>:<select class="js-calendar-second">秒</select></div>', this.dateArr = [], this.maxDays = 9999
		};
	return b.prototype = {
		separator: "-",
		defaultDate: new Date,
		setRange: function(b) {
			this.range = a.extend([null, null], b)
		},
		getDefaultDate: function() {
			var b = this;
			if (this.settings.target && a(this.settings.target).size() && (this.settings.focusDate = 1 === a(this.settings.target)[0].nodeType ? a(this.settings.target).val() || this.settings.focusDate || "" : a(this.settings.target).prev().val() || this.settings.focusDate || ""), this.settings.focusDate && !this.settings.multiple) {
				var c = this.settings.focusDate.split(" ")[0].split(this.separator),
					d = this.settings.focusDate.split(" ")[1] || "00:00:00";
				this.defaultDate = new Date(c[0], parseInt(c[1]) - 1, c[2], d.split(":")[0], d.split(":")[1], d.split(":")[2])
			}
			if (this.settings.focusDate && this.settings.multiple) {
				for (var e = this.settings.focusDate.split(","), f = e.length - 1; f >= 0; f--) {
					var g = e[f],
						c = g.split(this.separator);
					this.dateArr.push(new Date(c[0], parseInt(c[1]) - 1, c[2]))
				}
				this.defaultDate = this.dateArr[0], b._dateInArr(b.defaultDate, b.dateArr) || b.dateArr.push(b.date)
			}
		},
		init: function(b) {
			a("body").append('<div class="ui-calendar clearfix" id="' + this.id + '"><div class="ui-calendar-pannel clearfix" data-role="pannel"><span class="ui-calendar-control" data-role="prev-year">&lt;&lt;</span><span class="ui-calendar-control" data-role="prev-month">&lt;</span><span class="ui-calendar-control month" data-role="current-month"></span><span class="ui-calendar-control year" data-role="current-year"></span><span class="ui-calendar-control" data-role="next-month">&gt;</span><span class="ui-calendar-control" data-role="next-year">&gt;&gt;</span></div><div class="calendar-header clearfix"></div><div class="c_days clearfix"></div></div>'), this.calendarContainer = a("#" + this.id);
			this.settings = a.extend({}, this.settings, b), this.maxDays = this.settings.maxdays || this.maxDays, this.mutilSeparator = this.settings.mutilSeparator || ",", this.getDefaultDate(), this.settings.multiple && (this.settings.toolbar = !0);
			var c = this.settings.zIndex || 10000;
			this.calendarContainer.css("zIndex", c), this.date = this.defaultDate, this.setRange(this.settings.range), this.settings.time && (this.settings.toolbar = !0, this.autohide = !1, this.showTime(), this.showToolbar()), this.settings.toolbar && (this.autohide = !1, this.showToolbar()), this.bindEvent(), this.settings.target ? this.hide() : (this.autohide = !1, this.show())
		},
		showToolbar: function() {
			this.settings.toolbar && 0 == a(".ui-calendar-toolbar", this.calendarContainer).size() && this.calendarContainer.append(this.toolbarTpl)
		},
		showTime: function() {
			0 == this.calendarContainer.find(".ui-calendar-time").size() && this.calendarContainer.append(this.timeTpl);
			for (var b = this, c = 0, d = 60; d > c; c++) 24 > c && a(".js-calendar-hours", this.calendarContainer).append("<option>" + b._getTowNum(c) + "</option>"), a(".js-calendar-minutes", this.calendarContainer).append("<option>" + b._getTowNum(c) + "</option>"), a(".js-calendar-second", this.calendarContainer).append("<option>" + b._getTowNum(c) + "</option>"); {
				var e = this.date;
				b._getTowNum(e.getHours()) + ":" + b._getTowNum(e.getMinutes()) + ":" + b._getTowNum(e.getSeconds())
			}
			a(".js-calendar-hours", this.calendarContainer).val(b._getTowNum(e.getHours())), a(".js-calendar-minutes", this.calendarContainer).val(b._getTowNum(e.getMinutes())), a(".js-calendar-second", this.calendarContainer).val(b._getTowNum(e.getSeconds()))
		},
		show: function() {
			this.getDefaultDate(), this.calendarContainer.show(), this.date = this.defaultDate, this.formatDate(), this.renderHeader(), this.isShow = !0, this.setPosition(), this.settings.show && this.settings.show(this.calendarContainer);
			var a = this;
			this.timer = setInterval(function() {
				a.setPosition.call(a)
			}, 500), this.settings.time && (this.settings.toolbar = !0, this.autohide = !1, this.showTime())
		},
		hide: function() {
			this.calendarContainer.hide(), this.isShow = !1, this.settings.hide && this.settings.hide(this.calendarContainer), clearInterval(this.timer)
		},
		setPosition: function() {
			var b = 0,
				c = 0;
			if (this.settings.target && a(this.settings.target).size()) {
				1 === a(this.settings.target)[0].nodeType ? (c = a(this.settings.target).offset().top + a(this.settings.target).outerHeight(), b = a(this.settings.target).offset().left) : (c = a(this.settings.target).prev().offset().top + a(this.settings.target).prev().outerHeight(), b = a(this.settings.target).prev().offset().left);
				var d = a(window).scrollTop(),
					e = a(window).height();
				if (c + this.calendarContainer.outerHeight() > d + e) {
					var f = c - this.calendarContainer.outerHeight() - a(this.settings.target).outerHeight();
					f > 0 && (c = f)
				}
				this.calendarContainer.css({
					top: c,
					left: b
				})
			}
		},
		setDate: function(a) {
			var b, c = this;
			if ("object" == typeof a) c.defaultDate = a, b = a.getFullYear() + c.separator + c._getTowNum(a.getMonth() + 1) + c.separator + c._getTowNum(a.getDate()), c.settings.time && (b += " " + c._getTowNum(a.getHours()) + ":" + c._getTowNum(a.getMinutes()) + ":" + c._getTowNum(a.getSeconds()));
			else {
				var d = a.split(" "),
					e = d[0],
					f = d[1] || "00:00:00",
					g = e.split(c.separator);
				c.defaultDate = new Date(g[0], parseInt(g[1]) - 1, g[2], f.split(":")[0], f.split(":")[1], f.split(":")[2]), b = a
			}
			return c.date = c.defaultDate, b
		},
		bindEvent: function() {
			var b = this;
			a(".ui-calendar-control[data-role]", b.calendarContainer).click(function() {
				return b.go[a(this).data("role")].call(b), !1
			}), a(b.calendarContainer).click(function() {
				return !1
			}), a(".c_days", b.calendarContainer).delegate("li", "click", function() {
				if (b.settings.beforeSelect && b.settings.beforeSelect(b.date, b.calendarContainer), a(this).hasClass("disabled")) return !1;
				var c = a(this).data("value");
				if (b.setDate(c), b.settings.multiple) if (a(this).hasClass("focus")) b._removeDate(b.defaultDate, b.dateArr);
				else {
					if (b.maxDays <= b.dateArr.length) return b.settings.overdays && b.settings.overdays(b.maxDays, b.dateArr, b.calendarContainer), !1;
					b.dateArr.push(b.defaultDate)
				} else b.dateArr = [b.date];
				return b.formatDate(), b.renderHeader(), b.settings.selected && b.settings.selected(b.date, b.calendarContainer), b.settings.target && a(b.settings.target).size() && 1 === a(b.settings.target)[0].nodeType && b.autohide && (a(b.settings.target).val(c), b.hide(), b.settings.afterSelected && b.settings.afterSelected(a(b.settings.target), b.date, b.calendarContainer)), !1
			}), a(".ui-calendar-toolbar", b.calendarContainer).delegate("a", "click", function() {
				if (a(this).hasClass("js-calendar-submit")) {
					b.settings.selected && b.settings.selected(b.dateArr, b.calendarContainer), 0 === b.dateArr.length && b.dateArr.push(a(".focus", b.calendarContainer).data("value"));
					var c = b._toString(b.dateArr);
					e = c.join(b.mutilSeparator), b.settings.time && (e += " " + a(".js-calendar-hours", b.calendarContainer).val() + ":" + a(".js-calendar-minutes", b.calendarContainer).val() + ":" + a(".js-calendar-second", b.calendarContainer).val()), a(b.settings.target).val(e), b.hide()
				}
				if (a(this).hasClass("ui-calendar-close") && b.hide(), a(this).hasClass("ui-calendar-today")) {
					var d = new Date,
						e = b.setDate(d);
					b.date = d, b.hide(), a(b.settings.target).val(e)
				}
				a(this).hasClass("js-clear") && (b.dateArr = [], b.date = null, a(b.settings.target).val(""), b.formatDate()), b.settings.afterSelected && b.settings.afterSelected(a(b.settings.target), b.date, b.calendarContainer)
			}), b.settings.target && (a(b.settings.target).bind("click", function() {
				return a(this).hasClass("disabled") || a(this).filter('[disabled="true"]').size() > 0 ? void 0 : (a(document).trigger("click"), b.show(), !1)
			}), a(document).click(function() {
				b.isShow && b.hide()
			})), a(document).keydown(function(a) {
				27 === a.keyCode && b.hide()
			})
		},
		actionFlow: function(a, b) {
			a.siblings(".ui-calendar-flow").length ? a.siblings(".ui-calendar-flow").hide(300, function() {
				a[b](300)
			}) : a[b](300)
		},
		go: {
			"next-month": function() {
				this.month += 1, this._getDate(), this.formatDate(), this.renderHeader()
			},
			"prev-month": function() {
				this.month -= 1, this.changeDate()
			},
			"next-year": function() {
				this.year += 1, this.changeDate()
			},
			"prev-year": function() {
				this.year -= 1, this.changeDate()
			},
			"current-year": function(b) {
				var c = this;
				this.yearContainer ? b || c.actionFlow(c.yearContainer, "toggle") : (this.yearContainer = a('<div class="ui-year-list ui-calendar-flow"/>'), this.calendarContainer.append(this.yearContainer), c.actionFlow(c.yearContainer, "show"), this.yearContainer.on("click", "div", function() {
					var b = a(this).data("value");
					c.year = b, c.changeDate(), a(this).hasClass("cross") ? c.go["current-year"].call(c, !0) : c.actionFlow(c.yearContainer, "hide")
				}));
				var d = Math.floor(c.year / 10);
				this.yearContainer.html(""), this.yearContainer.append('<div class="cross prevtenyear" data-value="' + ((d - 1).toString() + 9) + '">...</div>');
				for (var e = 0, f = 10; f > e; e++) {
					var g = d.toString() + e,
						h = "";
					c.year == g && (h = ' class="current" '), this.yearContainer.append("<div " + h + ' data-value="' + g + '">' + g + "</div>")
				}
				this.yearContainer.append('<div class="cross nexttenyear" data-value="' + ((d + 1).toString() + 0) + '">...</div>')
			},
			"current-month": function() {
				var b = this;
				this.monthContainer ? b.actionFlow(b.monthContainer, "toggle") : (this.monthContainer = a('<div class="ui-month-list ui-calendar-flow"/>'), this.calendarContainer.append(this.monthContainer), b.actionFlow(b.monthContainer, "show"), this.monthContainer.on("click", "div", function() {
					var c = a(this).data("value");
					b.month = c, b.changeDate(), b.monthContainer.hide(300)
				})), this.monthContainer.html("");
				for (var c = 0, d = this.monthArr.length; d > c; c++) {
					var e = this.monthArr[c],
						f = "";
					b.month == c && (f = ' class="current" '), this.monthContainer.append("<div " + f + ' data-value="' + c + '">' + e + "</div>")
				}
			}
		},
		changeDate: function() {
			this._getDate(), this.formatDate(), this.renderHeader()
		},
		renderHeader: function() {
			a('[data-role="current-month"]', this.calendarContainer).html(this.monthArr[this.month]), a('[data-role="current-year"]', this.calendarContainer).html(this.year);
			for (var b = "", c = 0, d = this.dayArr.length; d > c; c++) b += "<b>" + this.dayArr[c] + "</b>";
			a(".calendar-header", this.calendarContainer).html(b)
		},
		_getDate: function() {
			this.date = new Date(this.year, this.month, this.day)
		},
		formatDate: function() {
			var b = this.date || this.defaultDate;
			this.year = b.getFullYear(), this.month = b.getMonth(), this.day = b.getDate();
			var c = new Date(this.year, this.month + 1, 0),
				d = c.getDate(),
				e = "<ul>",
				f = new Date(this.year, this.month, 1).getDay(),
				g = new Date(this.year, this.month, 0),
				h = g.getDate(),
				i = new Date(this.year, this.month + 2, 0);
			f > 0 && (e += this._getDay(h - f + 1, h, "preday", g)), e += this._getDay(1, d, "", b);
			var j = new Date(this.year, this.month, d).getDay();
			e += this._getDay(1, 6 - j, "nextday", i), e += "</ul>", a("#" + this.id).find(".c_days").html(e)
		},
		_toString: function(a) {
			for (var b = [], c = a.length, d = 0; c > d; d++) {
				var e = a[d];
				"string" == typeof e && (a[d] = new Date(e));
				for (var f = 0; d > f; f++) if (e.getTime() < a[f]) {
					var g = a[d];
					a[d] = a[f], a[f] = g
				}
			}
			for (var d = 0, h = a.length; h > d; d++) {
				var i = a[d],
					j = i.getFullYear(),
					k = this._getTowNum(i.getMonth() + 1),
					l = this._getTowNum(i.getDate());
				b.push(j + this.separator + k + this.separator + l)
			}
			return b
		},
		_getDay: function(a, b, c, d) {
			var e = "",
				f = this.range[0],
				g = this.range[1];
			f && (f = Date.parse(f)), g && (g = Date.parse(g));
			for (var h = a; b >= h; h++) {
				var i = c || "",
					j = d.getFullYear() + this.separator + this._getTowNum(d.getMonth() + 1) + this.separator;
				j += this._getTowNum(h);
				var k = new Date(d.getFullYear(), d.getMonth(), h),
					l = k.getTime();
				this.settings.multiple ? this._dateInArr(k, this.dateArr) && (i += " focus") : l == +new Date(this.defaultDate.getFullYear(), this.defaultDate.getMonth(), this.defaultDate.getDate()) && (i += " focus"), (f && f > l || g && l > g) && (i += " disabled"), this.settings.filter && !this.settings.filter(l) && (i += " disabled"), e += '<li class="' + i + '" data-value="' + j + '">' + h + "</li>"
			}
			return e
		},
		_dateInArr: function(a, b) {
			for (var c = b.length - 1; c >= 0; c--) {
				var d = b[c],
					e = d;
				if ("string" == typeof d) {
					var f = d.split(this.separator);
					e = new Date(f[0], parseInt(f[1]) - 1, f[2])
				}
				if (a.getTime() == e.getTime()) return !0
			}
		},
		_removeDate: function(a, b) {
			for (var c = [], d = b.length - 1; d >= 0; d--) {
				var e = b[d],
					f = e;
				if ("string" == typeof e) {
					var g = e.split(this.separator);
					f = new Date(g[0], parseInt(g[1]) - 1, g[2])
				}
				a.getTime() != f.getTime() && c.push(f)
			}
			this.dateArr = c
		},
		_getTowNum: function(a) {
			return ("0" + a.toString()).substr(-2)
		}
	}, b
});