# Single_Cycle_Processor

I have built a single cycle processor that can complete a handful of more common commands. This processor is built like a simple MIPS processor but instead uses ARMv8 Instruction Set Architecture, because this is the ISA I learned during my study abroad in the UK taught by Dr. Paul Gratz and Dr. Stavros Kalafatis.

The commands this processor can handle are as follows: and, or, add, subtract, add immeadiately, subtract immeadiately, move zero, branch, conditional branch if zero, load from memory, and store to memory. The commands of this processor are enough to have a fully functioning single cycle processor. I could add more commands by adding logic to the control path.

Building, implementing, and validating this processor has taught me multiple levels of knowledge of how processors work. I have gained knowledge in multiple levels of the processor hierarchy, but most of it is in the RTL level. The reason for this is coding the verilog for this processor, I built every part of the processor and learned how the pieces fit together.

The parts of my simple processor include: arithmetic logic unit, logic for the next program counter, register file housing 32 by 64 registers, sign extender, control unit to operate the controls, and finally the umbrella processor that puts all of the working units together. The diagram and control path of this processor will be attatched in the repository as well.

The last part of verifying that my processor works is using gtkwave to display the waveform of the processor. This helped debug the processor as I went along building the componets, because I could back track to the cause of any issue that came forth and fix it using the waveform. The waveform turned out to be a great tool to use!

Thank you for taking time to look at my processor, and hope you enjoyed it!