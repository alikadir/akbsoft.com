var baseURL;
var mediaURL;
var samiURL;
var NewState = 10;
var duration = true;
var isSetObjEnv = false;
var version = "1.0";
var isOpener;
var use_marquee_force;

// Frameset �� üũ�Ͽ� �����ӿ� ����
// frameset ID �� �ݵ�� "fst" �� ����
if(parent.frames[0] && typeof(parent.fst) != "undefined") {
	
	parent.rows = parent.fst.getAttribute("rows");
	parent.rows1 = parent.fst.getAttribute("rows1");
	parent.rows2 = parent.fst.getAttribute("rows2");
}

if(!opener) document.writeln("<script for=\"wmp\" event=\"playStateChange(NewState)\">playStateAction(NewState);</"+"script>\n");

// Windows Media Player Object �� üũ�Ͽ� �����ӿ� ���� (Event : onload)
function onloadInit() {
	if(opener) {
		isOpener = opener;
		wmp = opener.document.getElementById("wmp");
	} else {
		isOpener = this;
	}
	
	if(wmp == null) {
		setTimeout("onloadInit()",100);
		return false;
	} else {
		isObjLoaded = true;
	}
	
	if(opener) {
		setObjChkWin();
	} else {
		setObjEnv();
	}
} if(opener) { onloadInit(); } else {document.onload = window.setTimeout("onloadInit();",500); }

function setObjEnv() {
	if(isSetObjEnv == false && wmp != null) {
		wmp.URL = mediaURL;
		if(typeof(text_caption) != "undefined") wmp.closedCaption.captioningID = "text_caption";
		if(set_autoPlay == true) {
			wmp.controls.play();
		} else {
			wmp.controls.play();
			setTimeout("wmp.controls.stop();",50);
		}
		setToggleTab(view_player);
		setAutoRewind(set_autoRewind);
		setLoop(set_loop);
		setShuffle(set_shuffle);
		setMute(set_mute);
		setVolume(set_volume);
		
		isSetObjEnv = true;
	} else { onloadInit(); }
}

function setObjChkWin() {
	if(typeof(opener.wmp) == "undefined") {
		window.close();
	} setTimeout("setObjChkWin();",1000);
}

function aPlay() {
	wmp.controls.play();
}

function aStop() {
	wmp.controls.stop();
}

function aPause() {
	wmp.controls.pause();
}

function aPrev() {
	wmp.controls.previous();
}

function aNext() {
	wmp.controls.next();
}

function aREW() {
	var val = wmp.controls.currentPosition - 10;
	wmp.controls.currentPosition = val;
}

function aFF() {
	var val = wmp.controls.currentPosition + 10;
	wmp.controls.currentPosition = val;
}

function getPlaylist(target,obj) {
	if(typeof(wmp) != "undefined") {
		var res = "";
		var count = wmp.currentPlaylist.count;
		res += "<table width=100% style=table-layout:fixed; cellpadding=0 cellspacing=0>\n";
		for(i=0;i<=count-1;i++) {
			var itemname = wmp.currentPlaylist.item(i).name;
			var n = i+1;
			res += "	<tr><td align=right id=no>"+n+"</td><td nowrap id=name title=\""+itemname+"\"><span style=cursor:hand; onclick=playItem("+n+");>"+itemname+"</span></td><td align=right id=button><img src=images/btn_listen.gif style=cursor:hand; align=absmiddle onclick=playItem("+n+");><img src=images/btn_delete.gif style=cursor:hand; align=absmiddle onclick=deleteItem("+n+");getPlaylist();></td></tr>\n";
		}
		res += "</table>\n";
		if(!target) {
			playlist.innerHTML = res;
		} else {
			target.innerHTML = res;
		}
	}
}

function playStateAction(NewState) {
	switch(NewState) {
		case(0) : res = "Undefined - Windows Media Player is in an undefined state."; break;
		//case(1) : res = "Stopped - Playback of the current media clip is stopped."; break;
		case(1) : res = "M�zik Durduruldu! �almak &#304;�in Play Butonuna T&#305;klay&#305;n&#305;z."; break;
		//case(2) : res = "Paused - Playback of the current media clip is paused. When media is paused, resuming playback begins from the same location."; break;
		case(2) :
		case(3) : res = wmp.currentMedia.name; break;
		case(4) : res = "ScanForward - The current media clip is fast forwarding."; break;
		case(5) : res = "ScanReverse - The current media clip is fast rewinding."; break;
		case(6) : res = "Hat Kuruluyor - Yeni &#350;ark&#305; Serverden �a&#287;r&#305;l&#305;yor."; break;
		case(7) : res = "Bekleyiniz - Baglanti Kuruldu, Ne Yazikki Server Cevap Vermiyor. Waiting for session to begin."; break;
		case(8) : res = "B&uuml;t&uuml;n M&uuml;zik Listesi Bitti"; break;
		case(9) : res = "Bekleyiniz! - Yeni &#350;ark&#305; Y&uuml;kleniyor."; break;
		case(10) : res = "M&uuml;zik �almak &#304;�in Play Butonuna T&#305;klay&#305;n&#305;z."; break;
		case(11) : res = "Yeni Ba&#287;lant&#305; - Yeni Stream Ba&#287;lant&#305;s&#305;."; break;
		default : res = "Hata Durumu Bilinmiyor."; break;
	}
	
	if(NewState == 3) {
		afmObj_play(1);
	} else {
		afmObj_play(0);
	}
	if(use_marquee_force != false && use_marquee == true) {
		res = "<marquee name=text_marquee behavior="+marquee_behavior+" direction="+marquee_direction+" scrollamount="+marquee_scrollamount+" scrolldelay="+marquee_scrolldelay+" truespeed width=100% height=100%>"+res+"</marquee>";
	}
	text_title.innerHTML = res;
	getBitrate();
	getDuration();
}

function resetPlayer() {
	var cfm = confirm("M�Z�K L�STES�N� SIFIRLAMAKTAN EM�NM�S�N�Z?\B�T�N YAPMIS OLDUGUNUZ SE��MLER S�L�NECEKT�R.");
	if(cfm) {
		isSetObjEnv = false;
		setObjEnv();
		if(opener) setTimeout('getPlaylist();',250);
	}
}		

function deleteItem(no) {
	var cfm = confirm("BU SARKIYI SILMEK ISTEDIGINIZDEN EMINMISINIZ?");
	if(cfm) {
		var stats = wmp.playState;
		media = wmp.currentPlaylist.item(no-1);
		wmp.currentPlaylist.removeItem(media);
		if(stats == 3) { wmp.controls.play(); }
	}
}

function appendItem(url) {
	var newmedia = wmp.newMedia(url);
	wmp.currentPlaylist.appendItem(newmedia);
}

function openItem(url) {
	wmp.controls.stop();
	wmp.URL = url;
	wmp.controls.play();
}	

function playItem(no) {
	if(wmp.settings.mute == true) { setMute(false); }
	media = wmp.currentPlaylist.item(no-1);
	wmp.controls.playItem(media);
}

function setVolume(act) {
	currentVol = wmp.settings.volume;
	if(act == "up") {
		targetVol = currentVol + 5;
		if(targetVol >= 100) targetVol = 100;
	} else if(act == "down") {
		targetVol = currentVol - 5;
		if(targetVol <= 0) targetVol = 0;
	} else if(act <= 100) {
		targetVol = act;
	}
	isOpener.afmObj_volume(targetVol);
	wmp.settings.volume = targetVol;
}

function setAutoRewind(act) {
	if(act != true && act != false) {
		var stat = wmp.settings.getMode('autoRewind');
		if(stat == false) {
			stat = true;
		} else {
			stat = false;
		}
	} else {
		var stat = act;
	}
	wmp.settings.setMode('autoRewind',stat);
}

function setLoop(act) {
	if(act != true && act != false) {
		var stat = wmp.settings.getMode('loop');
		if(stat == false) {
			stat = true;
		} else {
			stat = false;
		}
	} else {
		var stat = act;
	}
	isOpener.afmObj_loop(stat);
	wmp.settings.setMode('loop',stat);
}

function setShuffle(act) {
	if(act != true && act != false) {
		var stat = wmp.settings.getMode('shuffle');
		if(stat == false) {
			stat = true;
		} else {
			stat = false;
		}
	} else {
		var stat = act;
	}
	isOpener.afmObj_shuffle(stat);
	wmp.settings.setMode('shuffle',stat);
}

function setMute(act) {
	if(act != true && act != false) {
		var stat = wmp.settings.mute;
		if(stat == false) {
			stat = true;
		} else {
			stat = false;
		}
	} else {
		var stat = act;
	}
	isOpener.afmObj_mute(stat);
	wmp.settings.mute = stat;
}

function setDurationType() {
	if(duration == true) {
		duration = false;
	} else {
		duration = true;
	}
	getDuration();
}

function timestamp2string(timestamp)
{
	var stringDate = new Date();
	stringDate.setTime(timestamp +"000");
	var h = 11 - stringDate.getHours();
	var m = stringDate.getMinutes();
	var s = stringDate.getSeconds();
	if(m < 10) m = "0"+m;
	if(s < 10) s = "0"+s;
	if(h > 0) {
		return  h+":"+m+":"+s;
	} else {
		return  m+":"+s;
	}
}

// Play �ǰ� �ִ� Position Time �� ǥ��
var pbs = 1;
function getDuration() {
	if(wmp != null) {
		if(view_duration == true && (wmp.playState == 3 || wmp.playState == 2)) {
			if(duration == true) {
				var res = wmp.controls.currentPositionString;
			} else if(duration == false) {
				var currPos = wmp.controls.currentPosition;
				var remainSec = wmp.currentMedia.duration - currPos;
				if(wmp.currentMedia.duration == 0) {
					duration = true;
					getDuration();
					return false;
				}
				var res = "-"+timestamp2string(parseInt(remainSec));
			}
		}
		if(!res) res = "00:00";
		
		if(wmp.playState == 2) {
			if(pbs == 1) {
				res = ":";
				pbs = 2;
			} else {
				pbs = 1;
			}
		}
		text_duration.innerHTML = res;
	}
} if(!opener) var IntvDuration = window.setInterval("getDuration();",1000);

// Play �ǰ� �ִ� Media �� Bitrate �� ǥ��
function getBitrate() {
	if(wmp != null) {
		if(view_bitrate == true && (wmp.playState == 3 || wmp.playState == 2)) {
			var mediaBitrate = wmp.currentMedia.getItemInfo("Bitrate");
			// MP3 bitrate �� 320000 �̻��̸� VBR , OGG�ϰ�� bitrate ����. = VBR
			if(mediaBitrate > 320000 || !mediaBitrate) { 
				mediaBitrate = "VBR";
			} else if(mediaBitrate > 1000) {
				mediaBitrate = parseInt(mediaBitrate / 1000) +"Kbps";
			} else {
				mediaBitrate = parseInt(mediaBitrate)+"bps";
			}
			var res = mediaBitrate;
		}
		if(!res) res = "&nbsp;";
		text_bitrate.innerHTML = res;
	}
} if(!opener) var IntvBitrate = window.setInterval("getBitrate();",5000);

// frameset �� ����� Toggle Show/Hide (setToggleTab �Լ��� ȣ��)
function toggleTab() {
	if(parent.rows != null) {
		switch(parent.fst.rows) {
			case(parent.rows2) :
				setToggleTab(0);
				break;
			case(parent.rows) :
				setToggleTab(1);
				break;
			case(parent.rows1) :
				setToggleTab(2);
				break;
		}
	}
}

function getSongTitle() {
	if(wmp.playState == 3 || wmp.playState == 2) {
		res = wmp.currentMedia.name;
	}
	text_title.innerHTML = res;
}

function setToggleTab(act) {
	if(parent.rows != null && typeof(table_tab) != "undefined") {
		var view = table_tab.getAttribute("alwaysview");
		switch(act) {
			case(1) :
				parent.fst.rows = parent.rows1;
				table_player.style.display = "block";
				if(view != "true") table_tab.style.display = "none";
				if(typeof(table_extend) != "undefined") table_extend.style.display = "none";
				break;
			case(2) :
				if(parent.rows2 != null) {
					parent.fst.rows = parent.rows2;
					table_player.style.display = "block";
					if(view != "true") table_tab.style.display = "none";
				  if(typeof(table_extend) != "undefined") table_extend.style.display = "block";
					break;
				}
			case(0) :
				if(parent.rows1 != null) {
					parent.fst.rows = parent.rows;
					table_player.style.display = "none";
					table_tab.style.display = "block";
					if(typeof(table_extend) != "undefined") table_extend.style.display = "none";
					break;
				}
			default :
				setToggleTab(1);
				break;
		}
	}
}

function openPlaylist() {
	if(isSetObjEnv == true) {
		window.open("playlist.html","playlist","width="+pl_window_width+",height="+pl_window_height+","+pl_window_options);
	}
}

function openMediaLibrary() {
	//dev...
	//window.open("lib/ml.php?s="+skin_name,"medialibrary","width="+ml_window_width+",height="+ml_window_height+","+ml_window_options);
}

function about() {
	var res =
		"  :+:+:+:+: aquAmp "+version+" :+:+:+:+:           \n"+
		"  Copyright(C)1999-2004. theaqua.com. All rights reserved.  \n"+
		"  E-mail: aquamp (at) bystyx.com,   Homepage : theaqua.com  \n"+
		"  --------------------------------------------------------  \n"+
		"  \""+skin_name+"\" Skin by "+skin_by+".                    \n"+
		"  E-mail   : "+skin_email+"                                 \n"+
		"  Homepage : "+skin_homepage+"                              \n"+
    "  Translator TR : "+skin_translator+"                       \n"+
    "  DOWNLOAD TR : "+skin_download+"                       \n"+
		"\n";
	alert(res);
}
