import QtQuick 2.0
import QtQuick.Dialogs 1.1
import MuseScore 3.0

MuseScore {
      menuPath: "Plugins.Proof Reading.Check Harmony Rules"
      description: "Basic rules for four-part harmony. Year1"
      version: "0.1"

      // colors taken from harmonyRules plugin
      property var colorFifth: "#e21c48";
      property var colorOctave: "#ff6a07";
      property var colorLargeInt: "#7b0e7f";
      property var colorError: "#ff6a64";

      property bool processAll: false;
      property bool errorChords: false;

      MessageDialog {
            id: msgMoreNotes
            title: "Warning"
            text: "This plugin only checks the top note of each voice.\nChords are ignored."
            
            onAccepted: {
                  Qt.quit();
            }

            visible: false;
      }

      function sgn(x) {
            if (x > 0) return(1);
            else if (x == 0) return(0);
            else return(-1);
      }

      function isBetween(note1,note2,n) {
            // test if pitch of note n is between note1 and note2
            if (note1.pitch > note2.pitch) {
                  if (n.pitch < note1.pitch && n.pitch > note2.pitch)
                        return true;
            } else {
                  if (n.pitch < note2.pitch && n.pitch > note1.pitch)
                        return true;
            }
            return false;
      }            

      function markColor(note1, note2, color) {
            note1.color = color;
            note2.color = color;
      }

      function markText(note1, note2, msg, color, trck, tick) {
            markColor(note1, note2, color);
            var myText = newElement(Element.STAFF_TEXT);
            myText.text = msg;
            //myText.pos.x = 0;
            myText.offsetY = 1;
            
            var cursor = curScore.newCursor();
            cursor.rewind(0);
            cursor.track = trck;
            while (cursor.tick < tick) {
                  cursor.next();
            }
            cursor.add(myText);
      }            

      function ischord7(note1, note2) {
      // note2 is transposing pitch
      // note1 is concert pitch
            var dtpc = note2.tpc - note1.tpc;
            var dpitch = note2.pitch - note1.pitch;

            
            if (sgn(dtpc) != sgn(dpitch))
                  return false;

            dtpc = Math.abs(dtpc);
            dpitch = Math.abs(dpitch) % 12;

            // My guess work to figure out how to resolve the 7th
            if (dtpc < 2)
                  return false;
            if (dtpc == 2 && dpitch == 2) 
                  return true;
           /* if (dtpc == 9 && dpitch == 2) 
                  return true;
            if (dtpc == 11 && dpitch == 5) 
                  return true;
            if (dtpc == 6 && dpitch == 6) 
                  return true;
            if (dtpc == 8 && dpitch == 8) 
                  return true;
            if (dtpc == 10 && dpitch == 10) 
                  return true;
            if (dtpc == 12 && dpitch == 16) 
                  return true;*/
                  
                     // if the note in the key is part of the V7 chord in let's say g major...., do that one note
            // g major = g(0) g#(1) a(2) a#(3) b(4) c(5) c#(6) d(7)d#(8) e(9) f(10) f#(11) g(12)
            //                        d              d           d                     d
            // d major = d(0) d#(1) e(2) f(3) f#(4) g(5) g#(6) a(7) a#(8) b(9) c(10) c#(11) d(12)
            //                        a              a          a                     a
            
           
            return false;
      }

      function checkDim47(note1, note2, track, tick) {
            var dtpc = note2.tpc - note1.tpc;
            var dpitch = note2.pitch - note1.pitch;

            // diminished intervals have opposite sgn for dtpc and dpitch
            if (sgn(dtpc) == sgn(dpitch)) {
                  return;
            }

            dtpc = Math.abs(dtpc);
            dpitch = Math.abs(dpitch) % 12;

            if (dtpc == 8 && dpitch == 4) { // dim. Fourth
                  markText(note1, note2, "dim. 4th, avoid for now",
                        colorError,track,tick);
            } else if (dtpc == 9 && dpitch == 9) { // dim. Seventh
                  markText(note1, note2, "dim. 7th, avoid for now",
                        colorError,track,tick);
            }
      }

      function checkDim5(note1, note2, note3, track, tick) {
            var dtpc = note2.tpc - note1.tpc;
            var dpitch = note2.pitch - note1.pitch;

            // diminished intervals have opposite sgn for dtpc and dpitch
            if (sgn(dtpc) == sgn(dpitch)) {
                  return;
            }

            dtpc = Math.abs(dtpc);
            dpitch = Math.abs(dpitch) % 12;

            if (dtpc == 6 && dpitch == 6) {
                  // check if note3 is inbetween
                  if (!isBetween(note1,note2,note3)) {
                        note3.color = colorError;
                        markText(note2,note3,
                        "dim. 5th should be followed by\nnote within interval",
                              colorError,track,tick);
                  }
            }
      }

      function check6NextNote(note1, note2, note3, track, tick) {
            var dtpc = note2.tpc - note1.tpc;
            var dpitch = note2.pitch - note1.pitch;
            var sameSgn = (sgn(dtpc) == sgn(dpitch));
            dtpc = Math.abs(dtpc);
            dpitch = Math.abs(dpitch) % 12;
      
            // check dim6th, min. 6th or maj. 6th
            if ((dtpc == 11 && dpitch == 7 && !sameSgn)
             || (dtpc == 4 && dpitch == 8 && !sameSgn)
             || (dtpc == 3 && dpitch == 9 && sameSgn)) {
                  // check if note3 is inbetween
                  if (!isBetween(note1,note2,note3)) {
                        note3.color = colorError;
                        markText(note1,note2,
                        "More than a 6th!",
                              colorError,track,tick);
                  } else {
                        markText(note1,note2,
                        "More than a 6th!",
                              colorError,track,tick);
                  }
            }
      }

      function check7AndLarger(note1, note2, track, tick, flag) {
            var dtpc = Math.abs(note2.tpc - note1.tpc);
            var dpitch = Math.abs(note2.pitch - note1.pitch);
            
            if (dpitch > 9 && dpitch != 12 && dtpc < 6) {
                  /*if (flag) {
                        markText(note1,note2,
                        "No 7ths, 9ths or larger\nnor with 1 note in between",
                        colorLargeInt,track,tick);
                  } else {
                        markText(note1, note2,
                        "No 7ths, 9ths or larger",colorLargeInt,track,tick);
                  }*/
            }
      }

      function isOctave(note1, note2) {
            var dtpc = Math.abs(note2.tpc - note1.tpc);
            var dpitch = Math.abs(note2.pitch - note1.pitch);
            if (dpitch == 12 && dtpc == 0)
                  return true;
            else
                  return false;
      }
      
     
      function check8(note1, note2, note3, track, tick) {
            // check if note2 and note3 form an octave
            // and note1 is not inbetween
            if (isOctave(note2,note3) && !isBetween(note2,note3,note1)) {
                  note3.color = colorError;
                  markText(note1,note2,
                        "Octave should be preceeded by note within compass",
                        colorError,track,tick);
            }
            // check if note1 and note2 form an octave
            // and note3 is not inbetween
            if (isOctave(note1,note2) && !isBetween(note1,note2,note3)) {
                  note3.color = colorError;
                  markText(note1,note2,
                        "Octave should be followed by note within compass",
                        colorError,track,tick);
            }
      }           

      onRun: {
            console.log("start")
            if (typeof curScore == 'undefined' || curScore == null) {
                  console.log("no score found");
                  Qt.quit();
            }

            // find selection
            var startStaff;
            var endStaff;
            var endTick;

            var cursor = curScore.newCursor();
            cursor.rewind(1);
            if (!cursor.segment) {
                  // no selection
                  console.log("no selection: processing whole score");
                  processAll = true;
                  startStaff = 0;
                  endStaff = curScore.nstaves;
            } else {
                  startStaff = cursor.staffIdx;
                  cursor.rewind(2);
                  endStaff = cursor.staffIdx+1;
                  endTick = cursor.tick;
                  if(endTick == 0) {
                        // selection includes end of score
                        // calculate tick from last score segment
                        endTick = curScore.lastSegment.tick + 1;
                  }
                  cursor.rewind(1);
                  console.log("Selection is: Staves("+startStaff+"-"+endStaff+") Ticks("+cursor.tick+"-"+endTick+")");
            }      

            // initialize data structure

            var changed = [];
            var curNote = [];
            var prevNote = [];
            var curRest = [];
            var prevRest = [];
            var curTick = [];
            var prevTick = [];

            var foundParallels = 0;

            var track;

            var startTrack = startStaff * 4;
            var endTrack = endStaff * 4;

            for (track = startTrack; track < endTrack; track++) {
                  curRest[track] = true;
                  prevRest[track] = true;
                  changed[track] = false;
                  curNote[track] = 0;
                  prevNote[track] = 0;
                  curTick[track] = 0;
                  prevTick[track] = 0;
            }

            // go through all staves/voices simultaneously

            if(processAll) {
                  cursor.track = 0;
                  cursor.rewind(0);
            } else {
                  cursor.rewind(1);
            }

            var segment = cursor.segment;

            while (segment && (processAll || segment.tick < endTick)) {
                  // Pass 1: read notes
                  for (track = startTrack; track < endTrack; track++) {
                        if (segment.elementAt(track)) {
                              if (segment.elementAt(track).type == Element.CHORD) {
                                    // we ignore grace notes for now
                                    var notes = segment.elementAt(track).notes;

                                    if (notes.length > 1) {
                                          console.log("found chord with more than one note!");
                                          errorChords = true;
                                    }

                                    var note = notes[notes.length-1];

                                    // check for some voice rules
                                    // if we have a new pitch
                                    if ((! curRest[track]) 
                                         && curNote[track].pitch != note.pitch) {
                                          // previous note present
                                          // check for chordal 7
                                          if (ischord7(note, curNote[track])) {
                                                markText(curNote[track],note,
                                                "chordal7th or doubled 7th",colorError,
                                                track,curTick[track]);
                                          }
                                          // check for diminished 4th and 7th
                                          checkDim47(curNote[track], note,
                                                track,curTick[track]);
                                          check7AndLarger(curNote[track],note,
                                                track,curTick[track],false);

                                          // have three notes?
                                          if (! prevRest[track]) {
                                                // check for diminished 5th
                                                checkDim5(prevNote[track],curNote[track],
                                                  note, track, prevTick[track]);
                                                // check for 6th
                                                check6NextNote(prevNote[track],curNote[track],
                                                  note, track, prevTick[track]);
                                                if(!isOctave(prevNote[track],curNote[track]) &&
                                                   !isOctave(curNote[track],note))
                                                      check7AndLarger(prevNote[track],note,
                                                        track,prevTick[track],true);
                                                check8(prevNote[track],curNote[track],note,
                                                      track, prevTick[track]);
                                          }
                                    }

                                    // remember note

                                    if (curNote[track].pitch != note.pitch) {
                                          prevTick[track]=curTick[track];
                                          prevRest[track]=curRest[track];
                                          prevNote[track]=curNote[track];
                                          changed[track]=true;
                                    } else {
                                          changed[track]=false;
                                    }
                                    curRest[track]=false;
                                    curNote[track]=note;
                                    curTick[track]=segment.tick;
                              } else if (segment.elementAt(track).type == Element.REST) {
                                    if (!curRest[track]) {
                                          // was note
                                          prevRest[track]=curRest[track];
                                          prevNote[track]=curNote[track];
                                          curRest[track]=true;
                                          changed[track]=false; // no need to check against a rest
                                    }
                              } else {
                                    changed[track] = false;
                              }
                        } else {
                              changed[track] = false;
                        }
                  }
                  // Pass 2: find paralleles
                  for (track=startTrack; track < endTrack; track++) {
                        var i;
                        // compare to other tracks
                        if (changed[track] && (!prevRest[track])) {
                              var dir1 = sgn(curNote[track].pitch - prevNote[track].pitch);
                              if (dir1 == 0) continue; // voice didn't move
                              for (i=track+1; i < endTrack; i++) {
                                    if (changed[i] && (!prevRest[i])) {
                                          var dir2 = sgn(curNote[i].pitch-prevNote[i].pitch);
                                          if (dir1 == dir2) { // both voices moving in the same direction
                                                var cint = curNote[track].pitch - curNote[i].pitch;
                                                var pint = prevNote[track].pitch-prevNote[i].pitch;
                                                // test for 5th
                                                if (Math.abs(cint%12) == 7) {
                                                      // test for open parallel
                                                      if (cint == pint) {
                                                            foundParallels++;
                                                            console.log ("P5:"+cint+", "+pint);
                                                            markText(prevNote[track],prevNote[i],"parallel 5th",
                                                                  colorFifth,track,prevTick[track]);
                                                            markColor(curNote[track],curNote[i],colorFifth);
                                                      } 
                                                      /*else if (dir1 == 1 && Math.abs(pint) < Math.abs(cint)) {
                                                            // hidden parallel (only when moving up)
                                                            foundParallels++;
                                                            console.log ("H5:"+cint+", "+pint);
                                                            markText(prevNote[track],prevNote[i],"hidden 5th",
                                                                  colorFifth,track,prevTick[track]);
                                                            markColor(curNote[track],curNote[i],colorFifth);
                                                      }*/                                                
                                                }
                                                // test for 8th
                                                if (Math.abs(cint%12) == 0) {
                                                      // test for open parallel
                                                      if (cint == pint) {
                                                            foundParallels++;
                                                            console.log ("P8:"+cint+", "+pint+"Tracks "+track+","+i+" Tick="+segment.tick);
                                                            markText(prevNote[track],prevNote[i],"parallel 8th",
                                                                  colorOctave,track,prevTick[track]);
                                                            markColor(curNote[track],curNote[i],colorOctave);
                                                      } 
                                                      /*else if (dir1 == 1 && Math.abs(pint) < Math.abs(cint)) {
                                                            // hidden parallel (only when moving up)
                                                            foundParallels++;
                                                            console.log ("H8:"+cint+", "+pint);
                                                            markText(prevNote[track],prevNote[i],"hidden 8th",
                                                                  colorOctave,track,prevTick[track]);
                                                            markColor(curNote[track],curNote[i],colorOctave);
                                                      }  */                                              
                                                }
                                          }
                                    }
                              }
                        }
                  }
                  segment = segment.next;
            }

            // set result dialog

            if (errorChords) {
                  console.log("finished with error");
                  msgMoreNotes.visible = true;
            } else {
                  console.log("finished");
                  Qt.quit();
            }
      }
      }
      
