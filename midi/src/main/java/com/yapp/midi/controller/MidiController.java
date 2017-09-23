package com.yapp.midi.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.sound.midi.InvalidMidiDataException;
import org.jfugue.midi.MidiFileManager;
import org.jfugue.pattern.Pattern;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yapp.midi.util.*;

@Controller
public class MidiController {

	public static String OUTPUT_FILENAME = "yapp1456.mid";
	public static String FILE_PATH = "";
	/*
	 * 
	 * iputfile list(max 36), 타악기
	 * outfile name
	 * 
	 * */
	@RequestMapping(value="/save", method=RequestMethod.POST)
	public ModelAndView appendMidiTest(
			@RequestParam(value="midis")String[] names,
			@RequestParam(value="seconds")String seconds,
			@RequestParam(value="bar")String bar,
			@RequestParam(value="bpm")String bpm,
			HttpServletRequest request ) throws IOException, InvalidMidiDataException{
		
		GenerateFileName gfn = new GenerateFileName();
		MidiToMp3Controller toMp3 = new MidiToMp3Controller();
		
		Pattern patternOne = null;
		Pattern resultMidi = new Pattern();
		String filename = null;
		String midiName = null;
		String mp3Name =  null;
		
		String resultPath = request.getSession().getServletContext().getRealPath("/resources/save/");
		String midiPath = request.getSession().getServletContext().getRealPath("/resources/midi/");
		
		if(names!=null){
			for(int i = 0; i<names.length; i++){
				patternOne = MidiFileManager.loadPatternFromMidi(new File(midiPath+names[i]));
				resultMidi.add(patternOne.toString());
			}			
		}
		try {
			filename = gfn.createName();
			midiName = filename +".mid";
			MidiFileManager.savePatternToMidi(resultMidi, new File(resultPath+midiName));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		try {
			mp3Name = toMp3.midiToMp3(resultPath+filename);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("result");
		mv.addObject("midiFile", mp3Name);
		mv.addObject("seconds", seconds);
		mv.addObject("bar", bar);
		mv.addObject("bpm", bpm);
		return mv;
	}
	
}
