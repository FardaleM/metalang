Imports System

Module montagnes

Dim eof As Boolean
Dim buffer As String
Function readChar_() As Char
  If buffer Is Nothing OrElse buffer.Length = 0 Then
    Dim tmp As String = Console.ReadLine()
    eof = (tmp Is Nothing)
    buffer = tmp + Chr(10)
  End If
  Return buffer(0)
End Function

Sub consommeChar()
  readChar_()
  buffer = buffer.Substring(1)
End Sub

Sub stdin_sep()
  Do
    If eof Then
      Return
    End If
    Dim c As Char = readChar_()
    If c = " "C Or c = Chr(13) Or c = Chr(9) Or c = Chr(10) Then
      consommeChar()
    Else
      Return
    End If
  Loop
End Sub

Function readInt() As Integer
  Dim i As Integer = 0
  Dim s as Char = readChar_()
  Dim sign As Integer = 1
  If s = "-"C Then
    sign = -1
    consommeChar()
  End If
  Do
    Dim c as Char = readChar_()
    If c <= "9"C And c >= "0"C Then
      i = i * 10 + Asc(c) - Asc("0"C)
      consommeChar()
    Else
      return i * sign
    End If
  Loop
End Function
  Function montagnes0(ByRef tab as Integer(), ByVal len as Integer) As Integer
    Dim max0 As Integer = 1
    Dim j As Integer = 1
    Dim i As Integer = len - 2
    Do While i >= 0
        Dim x As Integer = tab(i)
        Do While j >= 0 AndAlso x > tab(len - j)
            j = j - 1
        Loop
        j = j + 1
        tab(len - j) = x
        If j > max0 Then
            max0 = j
        End If
        i = i - 1
    Loop
    Return max0
  End Function
  
  
  Sub Main()
    Dim len As Integer = 0
    len = readInt
    stdin_sep
    Dim tab(len) As Integer
    For i As Integer = 0 To len - 1
        Dim x As Integer = 0
        x = readInt
        stdin_sep
        tab(i) = x
    Next
    Console.Write(montagnes0(tab, len))
    End Sub
    
  End Module
  
  