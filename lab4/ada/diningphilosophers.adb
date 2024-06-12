with Ada.Text_IO; use Ada.Text_IO;

package body diningphilosophers is

procedure Simulation( Philosophers_Number : Positive;
                      Meals_Number : Positive ) is

    -- Forks
    protected type Fork is
        entry Pick_Up;
        entry Put_Down;
    private
        Taken : Boolean := False;
    end Fork;

    protected body Fork is
        entry Pick_Up when not Taken is
        begin
            Taken := True;
        end Pick_Up;

        entry Put_Down when Taken is
        begin
            Taken := False;
        end Put_Down;
    end Fork;

    Forks_Array : array(1..Philosophers_Number) of Fork;

    -- Philosophers
    task type Philosopher is
        entry Set_ID( ID : Positive );
        entry Start;
    end Philosopher;

    task body Philosopher is
        Index : Positive;
        Left_Fork_Index : Positive;
        Right_Fork_Index : Positive;
        Left_Fork_Up : Boolean;
        Right_Fork_Up : Boolean;
        Eaten_Meals : Positive;
    begin
        accept Set_ID( ID : Positive ) do
            Index := ID;
            Left_Fork_Index := ID;
            Right_Fork_Index := (ID mod Philosophers_Number) + 1;
            Left_Fork_Up := False;
            Right_Fork_Up := False;
            Eaten_Meals := 1;
        end Set_ID;

        select
            accept Start;
        end select;

        while Eaten_Meals <= Meals_Number loop
            Put_Line("Philosopher " & Index'Image & " is thinking");

            if not Left_Fork_Up and not Right_Fork_Up then
                select
                    Forks_Array(Left_Fork_Index).Pick_Up;
                    Left_Fork_Up := True;
                    Put_Line("Philosopher " & Index'Image & " picked up left fork");
                else
                    Forks_Array(Right_Fork_Index).Pick_Up;
                    Right_Fork_Up := True;
                    Put_Line("Philosopher " & Index'Image & " picked up right fork");
                end select;

            elsif Left_Fork_Up and not Right_Fork_Up then
                select
                    Forks_Array(Right_Fork_Index).Pick_Up;
                    Right_Fork_Up := True;
                    Put_Line("Philosopher " & Index'Image & " picked up right fork");
                else
                    Forks_Array(Left_Fork_Index).Put_Down;
                    Left_Fork_Up := False;
                    Put_Line("Philosopher " & Index'Image & " put down left fork");
                end select;

            elsif not Left_Fork_Up and Right_Fork_Up then
                select
                    Forks_Array(Left_Fork_Index).Pick_Up;
                    Left_Fork_Up := True;
                    Put_Line("Philosopher " & Index'Image & " picked up left fork");
                else
                    Forks_Array(Right_Fork_Index).Put_Down;
                    Right_Fork_Up := False;
                    Put_Line("Philosopher " & Index'Image & " put down right fork");
                end select;
            
            elsif Left_Fork_Up and Right_Fork_Up then
                Put_Line("Philosopher " & Index'Image & " is eating " & Eaten_Meals'Image & " lunch");

                Forks_Array(Left_Fork_Index).Put_Down;
                Forks_Array(Right_Fork_Index).Put_Down;
                Left_Fork_Up := False;
                Right_Fork_Up := False;

                Eaten_Meals := Eaten_Meals + 1;
            end if;
        end loop;
    end Philosopher;

    Philosophers_Array : array(1..Philosophers_Number) of Philosopher;

begin
    For I in 1..Philosophers_Number loop
        begin
            Philosophers_Array(I).Set_ID(I);
            Philosophers_Array(I).Start;
        end;
    end loop;

end Simulation;

end diningphilosophers;
