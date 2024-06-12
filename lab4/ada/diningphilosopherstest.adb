with Ada.Command_Line; use Ada.Command_Line;
with diningphilosophers; use diningphilosophers;

procedure diningphilosophersTest is
begin
    if Argument_Count = 2 then 
        Simulation( Positive'Value(Argument(1)), 
                    Positive'Value(Argument(2)) );
    end if;
end diningphilosophersTest;
