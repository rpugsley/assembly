/**********************************************************************
*  PROGRAMA soma senoides no simulador                                *
***********************************************************************
*                                                                     *
*  
*                                                                     *
*  Geração de Senoide:                                                *
*                                                                     *
*                y(n) = A * y(n-1) + B * y(n-2)                       *
*                                                                     *
*                where  A/2    = 32768 * cos(2*pi*f/fs)               *
*                       B      = -1                                   *
*                       y(n-1) = 32768 * sin(2*pi*f/fs)  (init value) *
*                       y(n-2) = 0                       (init value) *
*                                                                     *
*                       f = freq da senoide                           *
*                       fs = frequencia de amostragem = 8 kHz         *
*                                                                     *
**********************************************************************/
#include <stdio.h>
 
int sinegen(int *, int *, int);

#define SAMPLES 50        /* NUMERO DE PONTOS */ 
int sample1[SAMPLES];    /* vetor de entrada */
int sample2[SAMPLES];    /* vetor de entrada */
int saida1a[SAMPLES];     /* vetor de saida */
int saida1b[SAMPLES];     /* vetor de saida */
int saida1c[SAMPLES];     /* vetor de saida */
void main(void)
{
    int osc1_y1 = 10126/4;     /* 400 Hz oscillator */
    int osc1_y2 = 0;
    int osc1_A  = 31164;
    int osc2_y1 = 31164/4;     /* 1600 Hz oscillator */
    int osc2_y2 = 0;
    int osc2_A  = 10126;
    int i;              
    /* clear the delay line and filter output array */
    for (i=0; i<SAMPLES; i++) sample1[i] = 0;
    for (i=0; i<SAMPLES; i++) sample2[i] = 0;
    for (i=0; i<SAMPLES; i++) saida1a[i] = 0; 
    for (i=0; i<SAMPLES; i++) saida1b[i] = 0;
	for (i=0; i<SAMPLES; i++) saida1c[i] = 0;

    /* generate the dual-tone frequency */
    for (i=0; i<SAMPLES; i++)
        {
        sample1[i] = sinegen(&osc1_y1,&osc1_y2,osc1_A);
        sample2[i] = sinegen(&osc2_y1,&osc2_y2,osc2_A); 
        /*soma 2 senoides de frequencia diferentes;  */
        saida1a[i] =  sample1[i] + sample2 [i];        
        /*soma 2 senoides de mesmo frequencia e fase;  */
        saida1b[i] =  sample1[i] + sample1 [i];   
		
	    }   
    	for (i=0; i<SAMPLES; i++)
        {
        
		  /*Soma 2 senoides de mesma frequencia mas de fazes deferentes.  */
         saida1c[i] =  sample1[i+5] + sample1[i];        
	         
        }

       	for (i=0; i<SAMPLES; i++)
        {
                 saida1c[i];
        }
    /* processamento */
 
 
 } 

/***************************************************************/
int sinegen(int *yn1, int *yn2, int A)
{
    int y;

    y = ((long)*yn1 * 2 * (long)A)>>15;
    y = y - *yn2;
    *yn2 = *yn1;
    *yn1 = y;
    return(y);
}
/***************************************************************/
